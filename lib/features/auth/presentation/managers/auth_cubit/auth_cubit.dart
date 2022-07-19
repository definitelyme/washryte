library auth_cubit.dart;

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/features/auth/domain/index.dart';
import 'package:washryte/utils/utils.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> with BaseCubit<AuthState>, _ImagePickerMixin {
  final AuthFacade _auth;
  User? _temp = User.blank();

  AuthCubit(this._auth) : super(AuthState.initial());

  void init({bool loader = false}) async {
    if (loader) toggleLoading(true, none());

    _temp = (await _auth.user).getOrElse(() => state.user);

    emit(state.copyWith(user: _temp!));

    if (loader) toggleLoading(false);
  }

  void initReset() async {
    final _cache = await _auth.getCacheEmail();
    emit(state.copyWith.user(email: _cache ?? state.user.email));
  }

  void initSocials() async {
    toggleLoading(true, none());

    final _value = await _auth.user;

    _value.fold(
      () => null,
      (user) {
        if (!isClosed) emit(state.copyWith(user: user ?? state.user));
      },
    );

    if (!isClosed) toggleLoading(false);
  }

  bool get isDirty => _temp != state.user;

  void toggleLoading([bool? isLoading, Option<AppHttpResponse?>? status]) =>
      emit(state.copyWith(isLoading: isLoading ?? !state.isLoading, status: status ?? state.status));

  void toggleOldPasswordVisibility() => emit(state.copyWith(isOldPasswordHidden: !state.isOldPasswordHidden));

  void togglePasswordVisibility() => emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));

  void nameChanged(String value) => emit(state.copyWith.user.call(fullName: DisplayName(value.trim())));

  void emailChanged(String value) => emit(state.copyWith.user.call(email: EmailAddress(value.trim())));

  void oldPasswordChanged(String value) => emit(state.copyWith(oldPassword: Password(value)));

  void passwordChanged(String value) => emit(state.copyWith(
        passwordMatches: state.user.confirmation.compare(value),
        user: state.user.copyWith(password: Password(value)),
      ));

  void passwordConfirmationChanged(String value) {
    emit(state.copyWith(
      passwordMatches: state.user.password.compare(value),
      user: state.user.copyWith(confirmation: Password(value)),
    ));
  }

  void phoneNumberChanged(String value) async {
    emit(state.copyWith(
      user: state.user.copyWith(phone: Phone(value.trim())),
      phoneTextController: state.phoneTextController
        ..text = value
        ..value = TextEditingValue(
          text: value,
          selection: TextSelection.fromPosition(TextPosition(offset: value.length)),
        ),
    ));
  }

  void otpCodeChanged(String value) => emit(state.copyWith(code: OTPCode(value, AuthState.OTP_CODE_LENGTH)));

  void createAccount() async {
    toggleLoading(true, none());

    env.flavor.fold(
      dev: () {
        if (state.user.login.isSome()) {
          final unique = UniqueId<String>.v4().value;
          if (state.user.fullName.getOrNull == null) nameChanged('John ${unique?.substring(0, 5)}');
          if (state.user.email.getOrNull == null) emailChanged('${UniqueId.v4().value}@forx.anonaddy.com');
          if (state.user.phone.getOrNull == null) phoneNumberChanged('${UniqueId.int(500000000, 4699999999).value}');
          if (state.user.password.getOrNull == null) passwordChanged('password');
          if (state.user.confirmation.getOrNull == null) passwordChanged('password');
        }
      },
      prod: () => null,
    );

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.signup.isNone()) {
      // Attempt Authentication
      final result = await _auth.createAccount(
        fullName: state.user.fullName,
        emailAddress: state.user.email,
        password: state.user.password,
        phone: state.user.phone,
        confirmation: state.user.confirmation,
      );

      // emit status
      emit(state.copyWith(status: optionOf(result)));
    }

    toggleLoading(false);
  }

  void login() async {
    toggleLoading(true, none());

    env.flavor.fold(
      dev: () {
        if (state.user.login.isSome()) {
          emailChanged('johndoe@gmail.com');
          passwordChanged('password');
        }
      },
      prod: () => null,
    );

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.login.isNone()) {
      // Attempt Authentication
      final result = await _auth.login(
        email: state.user.email,
        password: state.user.password,
      );

      emit(state.copyWith(
        status: optionOf(result?.copyWith(
          response: result.response.maybeMap(
            success: (s) => s.copyWith(pop: true),
            orElse: () => result.response,
          ),
        )),
      ));
    }

    toggleLoading(false);
  }

  Future<bool> forgotPassword([bool pop = true]) async {
    toggleLoading(true, none());

    AppHttpResponse? result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.email.isValid) {
      result = await _auth.sendPasswordResetInstructions(state.user.email);

      emit(state.copyWith(
        validate: result.response.maybeMap(success: (_) => false, orElse: () => state.validate),
        status: optionOf(
          result.copyWith(
            response: result.response.maybeMap(
              success: (s) => s.copyWith(pop: pop),
              orElse: () => result!.response,
            ),
          ),
        ),
      ));
    }

    toggleLoading(false);

    return result?.response.maybeMap(orElse: () => false, success: (_) => true) ?? false;
  }

  void resetPassword() async {
    toggleLoading(true, none());

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.email.isValid &&
        state.user.password.isValid &&
        state.code.isValid &&
        state.user.confirmation.isValid &&
        state.passwordMatches) {
      final result = await _auth.confirmPasswordReset(
        code: state.code,
        email: state.user.email,
        newPassword: state.user.password,
        confirmation: state.user.confirmation,
      );

      emit(state.copyWith(
        status: optionOf(
          result.copyWith(
            response: result.response.maybeMap(
              success: (s) => s.copyWith(pop: true),
              orElse: () => result.response,
            ),
          ),
        ),
      ));
    }

    toggleLoading(false);
  }

  void updateProfile() async {
    toggleLoading(true, none());

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.profile.isNone()) {
      final result = await _auth.updateProfile(
        fullName: state.user.fullName,
        email: state.user.email,
        image: state.selectedPhoto,
      );

      emit(state.copyWith(
        status: optionOf(
          result.copyWith(
            response: result.response.maybeMap(
              success: (s) => s.copyWith(pop: true),
              orElse: () => result.response,
            ),
          ),
        ),
      ));
    }

    toggleLoading(false);
  }

  void sleep() async {
    toggleLoading();
    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    await _auth.sleep();

    toggleLoading();
  }

  Future<void> googleAuth([bool notify = false]) async {
    emit(state.copyWith(isGoogleAuthLoading: true, status: none()));

    final result = await _auth.googleAuthentication(notify);

    emit(state.copyWith(isGoogleAuthLoading: false, status: result));
  }

  Future<void> appleAuth([bool notify = false]) async {
    emit(state.copyWith(isAppleAuthLoading: true, status: none()));

    final result = await _auth.appleAuthentication(notify);

    emit(state.copyWith(isAppleAuthLoading: false, status: result));
  }

  void updateSocialsProfile() async {
    toggleLoading(true, none());

    Option<AppHttpResponse?> result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.socials.isNone()) {
      result = await _auth.updateSocialsProfile(
        fullName: state.user.fullName,
        email: state.user.email,
        phone: state.user.phone.formatted,
      );

      emit(state.copyWith(status: result));

      await _auth.sink();
    }

    toggleLoading(false);
  }

  void updatePassword() async {
    toggleLoading(true, none());

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.oldPassword.isValid && state.user.password.isValid && state.user.confirmation.isValid && state.passwordMatches) {
      result = await _auth.updatePassword(
        current: state.oldPassword,
        newPassword: state.user.password,
        confirmation: state.user.confirmation,
      );

      emit(state.copyWith(
        status: optionOf(
          result.copyWith(
            response: result.response.maybeMap(
              success: (s) => s.copyWith(pop: true),
              orElse: () => result.response,
            ),
          ),
        ),
      ));
    }

    toggleLoading(false);
  }

  Future<void> deleteAccount() async {
    toggleLoading(true, none());

    final result = await _auth.deleteAccount();

    emit(state.copyWith(status: some(result)));

    toggleLoading(false);
  }
}

mixin _ImagePickerMixin on Cubit<AuthState> {
  final ImagePicker _picker = ImagePicker();

  void pickImage(ImageSource source) async {
    File? file;
    var fileSize = 0;

    var _result = await _picker.pickImage(source: source);

    if (_result == null)
      file = await _attemptFileRetrieval(_picker);
    else {
      file = File(_result.path);
      fileSize = file.lengthSync();
    }

    if (fileSize > Const.maxImageUploadSize) {
      emit(state.copyWith(
        status: some(AppHttpResponse.failure(
          'Max. image upload size is ${(Const.maxImageUploadSize / 1e+6).ceil()}MB',
        )),
      ));
      return;
    }

    if (file != null) emit(state.copyWith(selectedPhoto: file));
  }

  Future<File?> _attemptFileRetrieval(ImagePicker? picker) async {
    if (picker == null) return null;
    final _response = await _picker.retrieveLostData();
    if (!_response.isEmpty && _response.file != null) return File(_response.file!.path);
    return null;
  }
}
