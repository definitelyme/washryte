import 'dart:async';

import 'package:washryte/core/data/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/features/auth/domain/index.dart';
import 'package:washryte/manager/settings/external/preference_repository.dart';
import 'package:washryte/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_watcher_cubit.freezed.dart';
part 'auth_watcher_state.dart';

typedef Task = void Function(Either<Failure, Option<User?>> either);

@injectable
class AuthWatcherCubit extends Cubit<AuthWatcherState> {
  StreamSubscription<Either<Failure, Option<User?>>>? _authStateChanges;
  final AuthFacade _facade;
  final PreferenceRepository _preferences;
  StreamSubscription<Option<User?>>? _userChanges;

  AuthWatcherCubit(this._facade, this._preferences) : super(AuthWatcherState.initial()) {
    final value = _preferences.getBool(Const.userBalanceVisibilityKey);
    emit(state.copyWith(isBalanceHidden: value ?? state.isBalanceHidden));
  }

  @override
  Future<void> close() async {
    await unsubscribeAuthChanges;
    await unsubscribeUserChanges;
    return super.close();
  }

  Future<void> get unsubscribeAuthChanges async => await _authStateChanges?.cancel();
  Future<void> get unsubscribeUserChanges async => await _userChanges?.cancel();

  void _mapResponse(
    Either<AppHttpResponse, Option<User?>> response, {
    bool? isListeningForAuthChanges,
  }) {
    final option = response.getOrElse(() => none());
    final _user = option.getOrElse(() => null);

    if (isListeningForAuthChanges != null) emit(state.copyWith(isListeningForAuthChanges: true));

    response.fold(
      (httpResponse) {
        if (httpResponse.reason != AppNetworkExceptionReason.timedOut)
          emit(state.copyWith(
            isAuthenticated: _user != null,
            user: _user,
            option: optionOf(_user),
            status: optionOf(httpResponse),
          ));
        emit(state.copyWith(status: optionOf(httpResponse)));
      },
      (_) {
        emit(state.copyWith(
          isAuthenticated: _user != null,
          user: _user,
          option: option,
          status: none(),
        ));
      },
    );
  }

  Future<void> signOut() async {
    toggleLogoutLoading(true);

    await _facade.signOut();

    toggleLogoutLoading(false);

    emit(state.copyWith(
      isAuthenticated: false,
      user: null,
      option: none(),
      status: none(),
    ));
  }

  bool get isBalanceHidden => state.isBalanceHidden;

  void toggleBalance() {
    emit(state.copyWith(isBalanceHidden: !state.isBalanceHidden));
    _preferences.setBool(key: Const.userBalanceVisibilityKey, value: state.isBalanceHidden);
  }

  Future<void> subscribeToAuthChanges(Task actions) async {
    toggleLoading(true);

    // Get current user
    final _req = await _facade.currentUser;

    // await signOut();

    // Cancel previous subscription
    await unsubscribeAuthChanges;

    // Start new subsrciption
    _authStateChanges ??= _facade.onAuthStateChanges.listen((data) {
      _mapResponse(data, isListeningForAuthChanges: true);

      actions.call(data);

      toggleLoading(false);
    });

    _mapResponse(_req);

    // Only if user is authenticated, then fetch user data (called once!)
    await _req.fold(
      (f) async => f.fold(
        is41101: () async => await _facade.sink(),
        orElse: () => null,
      ),
      (_) async => await _facade.sink(),
    );

    toggleLoading(false);
  }

  Future<void> subscribeUserChanges() async {
    toggleLoading(true);

    await unsubscribeUserChanges;

    _userChanges ??= _facade.onUserChanges.listen((option) {
      final _user = option.getOrElse(() => null);

      emit(state.copyWith(
        isListeningForUserChanges: true,
        isAuthenticated: _user != null,
        user: _user,
        option: optionOf(_user),
        status: none(),
      ));
    });

    toggleLoading(false);
  }

  void toggleLoading([bool? isLoading]) => emit(state.copyWith(isLoading: isLoading ?? !state.isLoading));

  void toggleLogoutLoading([bool? value]) => emit(state.copyWith(isLoggingOut: value ?? !state.isLoggingOut));
}
