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
import 'package:washryte/features/dashboard/data/repositories/utilities_repository/utilities_repository.dart';
import 'package:washryte/manager/settings/external/preference_repository.dart';
import 'package:washryte/utils/utils.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> with BaseCubit<AuthState>, _ImagePickerMixin {
  final AuthFacade _auth;
  final PreferenceRepository _preferences;
  final UtilitiesRepository _utils;

  AuthCubit(
    this._auth,
    this._preferences,
    this._utils,
  ) : super(AuthState.initial());

  @override
  Future<void> close() {
    // state.phoneTextController.dispose();
    return super.close();
  }

  void init({bool loader = false}) async {
    if (loader) toggleLoading();

    // Retrieve stored / cached user data
    final _user = await _auth.user;

    final _cache = await _preferences.getString(Const.kPhoneNumberPrefKey);

    (_user.getOrElse(() => null) ?? state.user).let((it) => emit(state.copyWith(
          user: it.copyWith(
            phone: _cache?.let((number) => Phone(number)) ??
                it.phone.ensure(
                  (p0) => (p0 as Phone),
                  orElse: (_) => state.user.phone,
                ),
          ),
        )));

    if (loader) toggleLoading();
  }

  void initSocials() async {
    toggleLoading(true, none());

    final _value = await _auth.user;

    _value.fold(
      () => null,
      (user) {
        // full name
        final fullName = user?.firstName.getOrNull?.split(' ');
        // first name
        final firstName = fullName != null && fullName.isNotEmpty ? DisplayName(fullName[0]) : user?.firstName;
        final lastName = fullName != null && fullName.length > 1 ? DisplayName(fullName[1]) : user?.lastName;

        if (!isClosed)
          emit(state.copyWith(
            user: user?.copyWith(firstName: firstName!, lastName: lastName!) ?? state.user,
          ));
      },
    );

    if (!isClosed) toggleLoading(false);
  }

  void toggleLoading([bool? isLoading, Option<AppHttpResponse?>? status]) => emit(state.copyWith(
        isLoading: isLoading ?? !state.isLoading,
        status: status ?? state.status,
      ));

  void toggleOldPasswordVisibility() => emit(state.copyWith(isOldPasswordHidden: !state.isOldPasswordHidden));

  void togglePasswordVisibility() => emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));

  void firstNameChanged(String value) => emit(state.copyWith.user.call(firstName: DisplayName(value.trim())));

  void lastNameChanged(String value) => emit(state.copyWith.user.call(lastName: DisplayName(value.trim())));

  void emailChanged(String value) => emit(state.copyWith.user.call(email: EmailAddress(value.trim())));

  void oldPasswordChanged(String value) => emit(state.copyWith(oldPassword: Password(value)));

  void phoneNumberChanged(String value) async => emit(state.copyWith.user.call(phone: Phone(value.trim())));

  void passwordChanged(String value) {
    emit(state.copyWith(
      passwordMatches: state.confirmPassword.compare(value),
      user: state.user.copyWith(password: Password(value)),
    ));
  }

  void passwordConfirmationChanged(String value) {
    emit(state.copyWith(
      passwordMatches: state.user.password.compare(value),
      confirmPassword: Password(value),
    ));
  }

  void createAccount() async {
    toggleLoading(true, none());

    AppHttpResponse? result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.signup.isNone()) {
      // Attempt Authentication
      result = await _auth.createAccount(
        firstName: state.user.firstName,
        lastName: state.user.lastName,
        emailAddress: state.user.email,
        password: state.user.password,
        phone: state.user.phone.formatted!,
      );

      // emit status
      emit(state.copyWith(status: optionOf(result)));
    }

    toggleLoading(false);
  }

  void login() async {
    toggleLoading(true, none());

    AppHttpResponse? result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.login.isNone()) {
      // Attempt Authentication
      result = await _auth.login(
        email: state.user.email,
        password: state.user.password,
      );

      emit(state.copyWith(
        status: optionOf(result != null
            ? result.copyWith(
                response: result.response.maybeMap(
                  success: (s) => s.copyWith(pop: true),
                  orElse: () => result!.response,
                ),
              )
            : result),
      ));
    }

    toggleLoading(false);
  }

  Future<void> resendPhoneOTP() async {
    toggleLoading(true, none());

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.phone.isValid) {
      result = await _auth.resendVerificationEmail(state.user.phone);

      emit(state.copyWith(status: optionOf(result)));
    }

    toggleLoading(false);
  }

  Future<void> verifyPhone() async {
    toggleLoading(true, none());

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.code.isValid) {
      result = await _auth.verifyPhoneNumber(
        phone: state.user.phone,
        token: state.code,
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

  Future<bool> forgotPassword([bool pop = true]) async {
    toggleLoading(true, none());

    AppHttpResponse? result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.phone.isValid || state.user.email.isValid) {
      final email = state.user.email;
      final phone = state.user.phone.formatted?.getOrNull != null ? state.user.phone.formatted! : state.user.phone;

      result = await _auth.sendPasswordResetInstructions(
        phone: phone,
        email: email,
      );

      await result.response.maybeMap(
        orElse: () async => null,
        success: (s) async => await _preferences.setString(
          key: Const.kPhoneNumberPrefKey,
          value: phone.getOrEmpty!,
        ),
      );

      emit(state.copyWith(
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

    return result?.response.map(
          error: (_) => false,
          success: (_) => true,
        ) ??
        false;
  }

  void resetPassword() async {
    toggleLoading(true, none());

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.phone.isValid &&
        state.user.password.isValid &&
        state.code.isValid &&
        state.confirmPassword.isValid &&
        state.passwordMatches) {
      result = await _auth.confirmPasswordReset(
        code: state.code,
        phone: state.user.phone,
        newPassword: state.user.password,
        confirmation: state.confirmPassword,
      );

      await result.response.maybeMap(
        orElse: () async => null,
        success: (s) async => await _preferences.remove(Const.kPhoneNumberPrefKey),
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

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.profile.isNone()) {
      result = await _auth.updateProfile(
        firstName: state.user.firstName,
        lastName: state.user.lastName,
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

  Future<void> sendPhoneUpdateOTP([bool shouldPop = true]) async {
    toggleLoading(true, none());

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.phone.isValid) {
      result = await _auth.updatePhone(state.user.phone.formatted!);

      emit(state.copyWith(
        status: optionOf(
          result.copyWith(
            response: result.response.maybeMap(
              success: (s) => s.copyWith(pop: shouldPop),
              orElse: () => result.response,
            ),
          ),
        ),
      ));
    }

    toggleLoading(false);
  }

  void confirmPhoneUpdate() async {
    toggleLoading(true, none());

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.phone.isValid && state.code.isValid) {
      result = await _auth.confirmUpdatePhone(
        phone: state.user.phone.formatted!,
        code: state.code,
      );

      await result.response.maybeMap(
        orElse: () async => null,
        success: (s) async => await _preferences.remove(Const.kPhoneNumberPrefKey),
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

  Future<void> googleAuth([bool notify = false]) async {
    emit(state.copyWith(isGoogleAuthLoading: true, status: none()));

    var result = await _auth.googleAuthentication(notify);

    emit(state.copyWith(status: result));
    emit(state.copyWith(isGoogleAuthLoading: false));
  }

  Future<void> appleAuth([bool notify = false]) async {
    emit(state.copyWith(isAppleAuthLoading: true, status: none()));

    var result = await _auth.appleAuthentication(notify);

    emit(state.copyWith(status: result));
    emit(state.copyWith(isAppleAuthLoading: false));
  }

  void updateSocialsProfile() async {
    toggleLoading(true, none());

    Option<AppHttpResponse?> result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.user.socials.isNone()) {
      result = await _auth.updateSocialsProfile(
        firstName: state.user.firstName,
        lastName: state.user.lastName,
        email: state.user.email,
        phone: state.user.phone.formatted,
      );

      emit(state.copyWith(status: result));
    }

    toggleLoading(false);
  }

  void updatePassword() async {
    toggleLoading(true, none());

    AppHttpResponse result;

    // Enable form validation
    emit(state.copyWith(validate: true, status: none()));

    if (state.oldPassword.isValid && state.user.password.isValid && state.confirmPassword.isValid && state.passwordMatches) {
      result = await _auth.updatePassword(
        current: state.oldPassword,
        newPassword: state.user.password,
        confirmation: state.confirmPassword,
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
