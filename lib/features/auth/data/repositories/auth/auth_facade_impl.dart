library auth_facade_impl.dart;

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:washryte/core/data/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/auth/data/models/index.dart';
import 'package:washryte/features/auth/data/repositories/auth/social_auth_mixin.dart';
import 'package:washryte/features/auth/data/sources/local/auth_local_source.dart';
import 'package:washryte/features/auth/data/sources/remote/auth_remote_source.dart';
import 'package:washryte/features/auth/domain/index.dart';
import 'package:washryte/manager/settings/external/preference_repository.dart';
import 'package:washryte/utils/utils.dart';

@LazySingleton(as: AuthFacade)
class AuthFacadeImpl extends AuthFacade with SocialAuthMixin {
  @override
  final FirebaseAnalytics analytics;

  @override
  final GoogleSignIn googleSignIn;

  @override
  final AuthLocalDatasource local;

  @override
  final AuthRemoteDatasource remote;

  final StreamController<Either<AppHttpResponse, Option<User?>>> __controller;
  final StreamController<Option<User?>> __userChagesController;

  final PreferenceRepository preferences;

  AuthFacadeImpl(
    this.remote,
    this.local,
    this.googleSignIn,
    this.analytics,
    this.preferences,
  )   : __controller = StreamController.broadcast(),
        __userChagesController = StreamController.broadcast();

  @override
  Future<Option<User?>> get user async => (await retrieveAndCacheUpdatedUser(forceGetLocalCache: true)).getOrElse(() => none());

  @override
  Future<Either<AppHttpResponse, Option<User?>>> get currentUser async => retrieveAndCacheUpdatedUser(forceGetLocalCache: false);

  @override
  Future<AppHttpResponse> confirmPasswordReset({
    required Phone phone,
    required OTPCode code,
    required Password newPassword,
    required Password confirmation,
  }) async {
    try {
      final _conn = await checkInternetConnectivity();

      final dto = UserDTO(
        phone: phone.getOrNull,
        token: code.getOrNull,
        password: newPassword.getOrNull,
        confirmation: confirmation.getOrNull,
      );

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Attempt Authentication
        (r) async => remote.confirmPasswordReset(dto),
      );

      return AppHttpResponse.fromJson(_response.data as Map<String, dynamic>);
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace);
    }
  }

  @override
  Future<AppHttpResponse> confirmUpdatePhone({
    required Phone phone,
    required OTPCode code,
  }) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Update user profile
        (_) => remote.confirmUpdatePhoneNumber(
          phone: phone.getOrNull,
          token: code.getOrNull,
        ),
      );

      final cached = await retrieveAndCacheUpdatedUser();

      await cached.fold((l) => null, (user) async => update(user));

      return AppHttpResponse.fromJson(_response.data as Map<String, dynamic>);
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace);
    }
  }

  @override
  Future<AppHttpResponse?> createAccount({
    required DisplayName firstName,
    required DisplayName lastName,
    required EmailAddress emailAddress,
    required Password password,
    required Phone phone,
  }) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) async => throw f,
        // Attempt Registration
        (_) async => remote.createUserAccount(
          UserDTO.fromDomain(User.blank(
            firstName: firstName,
            lastName: lastName,
            email: emailAddress,
            password: password,
            phone: phone,
          )),
        ),
      );

      // Get Data Access Object
      final _registered = RegisteredUserDTO.fromJson(
        _response.data as Map<String, dynamic>,
      );

      await phone.getOrEmpty?.let((it) async => await preferences.setString(key: Const.kPhoneNumberPrefKey, value: it));

      // Automatically Login new User
      return await login(
        email: emailAddress,
        password: password,
        registered: _registered.data?.copyWith(
          password: password.getOrNull,
        ),
      );
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace);
    }
  }

  @override
  Future<AppHttpResponse> deleteAccount() async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      return _conn.fold(
        (f) async => f,
        (r) async {
          final _response = await remote.deleteAccount();

          await sink(await currentUser);

          await signOut(notify: true);

          return AppHttpResponse.fromJson(_response.data as Map<String, dynamic>);
        },
      );
    } on AppHttpResponse catch (ex, trace) {
      return await handleFailure(e: ex, trace: trace, notify: true);
    } on AppNetworkException catch (ex, trace) {
      return await handleFailure(e: ex.asResponse(), trace: trace, notify: true);
    }
  }

  @override
  Future<AppHttpResponse?> login({
    required EmailAddress email,
    required Password password,
    UserDTO? registered,
  }) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Attempt Authentication
        (r) async => remote.login(
          email: email.getOrNull,
          password: password.getOrNull,
        ),
      );

      //// Cache Access token
      await local.cacheUserAccessToken(_response.data);

      // If login was successful, fetch updated user creds
      // Else we'll pass in the initial registration response for caching
      var temp = UserDTO.fromDomain(
        User.blank(email: email, password: password),
      );

      final cached = await retrieveAndCacheUpdatedUser(
        shouldThrow: true,
        dto: registered ?? temp,
      );

      // Log Firebase Analytics Login event
      await analytics.logLogin(loginMethod: 'email');

      return await cached.fold(
        (failure) async {
          await sink();
          return AppHttpResponse(failure.response);
        },
        (o) async {
          await sink();
        },
      );
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace);
    }
  }

  @override
  Stream<Either<AppHttpResponse, Option<User?>>> get onAuthStateChanges => __controller.stream;

  @override
  Stream<Option<User?>> get onUserChanges => __userChagesController.stream;

  @override
  Future<AppHttpResponse> resendVerificationEmail(
    Phone phone,
  ) async {
    try {
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Attempt Authentication
        (r) async => remote.resendPhoneVerification(phone.getOrEmpty),
      );

      return AppHttpResponse.fromJson(_response.data as Map<String, dynamic>);
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace);
    }
  }

  @override
  Future<Either<AppHttpResponse, Option<User?>>> retrieveAndCacheUpdatedUser({
    UserDTO? dto,
    bool shouldThrow = false,
    bool forceGetLocalCache = false,
  }) async {
    Future<Either<AppHttpResponse, Option<User?>>> _local(AppHttpResponse failure) async {
      if (forceGetLocalCache) return right((await local.getUser()).fold(() => none(), (dto) => some(dto?.domain)));

      return failure.fold(
        // if reason for failure was 401,
        // logout the user (probably an expired accessToken)
        is401: () {
          // TODO: Find a way to fix this.."notify" should be false normally
          // Because in this app, we can have guest users
          signOut(notify: true);
          return left(failure);
        },
        is41101: () => left(failure),
        // Unverified phone number
        is4031: () async {
          await preferences.setString(
            key: Const.kPhoneNumberPrefKey,
            value: failure.data?['phone'] as String? ?? '',
          );
          return left(failure);
        },
        // Else proceed with local fetch
        orElse: () async => right((await local.getUser()).fold(
          () => none(),
          (dto) => some(dto?.domain),
        )),
      );
    }

    // Cache incoming user data
    await dto?.let((it) => local.cacheAuthenticatedUser(it));

    // Check if device has good connection
    final _conn = await checkInternetConnectivity();
    // Fetch Updated user info from remote source
    return _conn.fold(
      (f) async {
        if (shouldThrow)
          throw left(f);
        else
          return (await _local(f)).fold(
            (_) => left(f),
            (option) => option.fold(
              () => left(f),
              (_) => right(option),
            ),
          );
      },
      (_) async => (await remote.getUser()).fold(
        // If could not retrieve data form server, fetch local
        (f) {
          // if (f.reason == AppNetworkExceptionReason.timedOut ||
          //     f.reason == AppNetworkExceptionReason.noInternet) return left(f);
          return _local(f);
        },
        (dto) async {
          // Cache updated user data
          await dto?.let((it) => local.cacheAuthenticatedUser(it));
          return right(some(dto?.domain));
        },
      ),
    );
  }

  @override
  Future<AppHttpResponse> sendPasswordResetInstructions({
    Phone? phone,
    EmailAddress? email,
  }) async {
    try {
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Attempt Authentication
        (r) async => remote.sendPasswordResetMessage(
          phone: phone?.getOrNull,
          email: email?.getOrNull,
        ),
      );

      return AppHttpResponse.fromJson(_response.data as Map<String, dynamic>);
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace);
    }
  }

  @override
  Future<void> signOut({
    bool notify = true,
    bool regular = true,
    bool google = true,
    bool apple = true,
  }) async {
    try {
      if (regular) await preferences.remove(Const.kPhoneNumberPrefKey);
      // Sign user-out of all services
      await Future.wait([
        if (regular) remote.signOut(),
        if (google) googleSignIn.signOut(),
        // Delete local
        if (regular) local.signOut(),
      ]);

      // Notify listeners about sign-out
      if (notify) await sink(right(none()));
    } catch (_) {
      // Delete local cache
      await Future.wait([local.signOut()]);

      // Notify listeners about sign-out
      if (notify) await sink(right(none()));
    }
  }

  @override
  Future<void> sink([Either<AppHttpResponse, Option<User?>>? userOrFailure]) async =>
      __controller.sink.add(userOrFailure ?? await currentUser);

  @override
  Future<void> sleep() async {
    try {
      await remote.timeout();
    } on AppHttpResponse catch (ex) {
      log.w(ex);
    } on AppNetworkException catch (ex) {
      log.w(ex.asResponse());
    }
  }

  @override
  Future<void> update(Option<User?> user) async => __userChagesController.sink.add(user);

  @override
  Future<AppHttpResponse> updatePassword({
    required Password current,
    required Password newPassword,
    required Password confirmation,
  }) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Update user profile
        (_) => remote.updatePassword(
          current: current.getOrEmpty,
          newPassword: newPassword.getOrEmpty,
          confirmation: confirmation.getOrEmpty,
        ),
      );

      final _return = AppHttpResponse.fromJson(
        _response.data as Map<String, dynamic>,
      );

      await _return.response.map(
        error: (_) => null,
        success: (_) async {
          final cached = await retrieveAndCacheUpdatedUser();
          await cached.fold((l) => null, (user) async => update(user));
        },
      );

      return _return;
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace, notify: false);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace, notify: false);
    }
  }

  @override
  Future<AppHttpResponse> updatePhone(Phone? phone) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Update user profile
        (_) => remote.updatePhoneNumber(phone?.getOrEmpty),
      );

      await phone?.getOrEmpty?.let(
        (it) => preferences.setString(
          key: Const.kPhoneNumberPrefKey,
          value: it,
        ),
      );

      return AppHttpResponse.fromJson(_response.data as Map<String, dynamic>);
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace, notify: false);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace, notify: false);
    }
  }

  @override
  Future<AppHttpResponse> updateProfile({
    DisplayName? firstName,
    DisplayName? lastName,
    EmailAddress? email,
    File? image,
  }) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Update user profile
        (_) => remote.updateProfile(
          image: image,
          dto: UserDTO.fromDomain(User.blank(
            firstName: firstName,
            lastName: lastName,
            email: email,
          )),
        ),
      );

      final user = RegisteredUserDTO.fromJson(
        _response.data as Map<String, dynamic>,
      );

      final _return = AppHttpResponse.fromJson(
        _response.data as Map<String, dynamic>,
      );

      await _return.response.map(
        error: (_) => null,
        success: (_) async {
          await user.dto?.let((it) => local.cacheAuthenticatedUser(it));
          await update(some(user.domain));
        },
      );

      return _return;
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace, notify: false);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace, notify: false);
    }
  }

  @override
  Future<Option<AppHttpResponse?>> updateSocialsProfile({
    DisplayName? firstName,
    DisplayName? lastName,
    EmailAddress? email,
    Username? username,
    Phone? phone,
  }) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        // Re-Throw Exception
        (f) => throw f,
        // Update user profile
        (_) => remote.updateSocialsProfile(
          UserDTO.fromDomain(User.blank(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
          )),
        ),
      );

      final _return = AppHttpResponse.fromJson(
        _response.data as Map<String, dynamic>,
      );

      return await _return.response.map(
        error: (_) => none(),
        success: (_) async {
          final _userOrFailure = await currentUser;
          return _userOrFailure.fold(
            (failure) => optionOf(failure),
            (_) => none(),
          );
        },
      );
    } on AppHttpResponse catch (ex, trace) {
      return optionOf(await handleFailure(e: ex, trace: trace));
    } on AppNetworkException catch (ex, trace) {
      return optionOf(await handleFailure(e: ex.asResponse(), trace: trace));
    }
  }

  @override
  Future<AppHttpResponse> verifyPhoneNumber({
    required Phone phone,
    required OTPCode token,
  }) async {
    try {
      // Check if device has good connection
      final _conn = await checkInternetConnectivity();

      final _response = await _conn.fold(
        (f) => throw f,
        (_) => remote.verifyPhoneNumber(
          phone: phone.getOrEmpty,
          token: token.getOrEmpty,
        ),
      );

      // verification successful, fetch & cache fresh user data
      final _return = AppHttpResponse.fromJson(
        _response.data as Map<String, dynamic>,
      );

      await _return.response.map(
        error: (_) => null,
        success: (_) async {
          final cached = await retrieveAndCacheUpdatedUser();

          await cached.fold((l) => null, (user) async {
            await sink(cached);
            await update(user);
          });
        },
      );

      return _return;
    } on AppHttpResponse catch (ex, trace) {
      return handleFailure(e: ex, trace: trace, notify: false);
    } on AppNetworkException catch (ex, trace) {
      return handleFailure(e: ex.asResponse(), trace: trace, notify: false);
    }
  }
}
