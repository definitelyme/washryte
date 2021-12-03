library auth_remote_source.dart;

import 'dart:io';

import 'package:washryte/core/data/index.dart';
import 'package:washryte/features/auth/data/models/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRemoteDatasource {
  static const String profileImgKey = 'image';
  static const String socialsTokenKey = 'token';

  final AppHttpClient _dio;

  AuthRemoteDatasource(this._dio);

  Future<Response<dynamic>> createUserAccount(UserDTO dto) async {
    // Generate Form Data for request
    final data = FormData.fromMap(dto.toJson());
    // Perform POST request based on role / user_type
    return await _dio.post(EndPoints.REGISTER, data: data);
  }

  Future<Response<dynamic>> login({
    required String? email,
    required String? password,
  }) async {
    // Convert data to DTO
    final dto = UserDTO(email: email, password: password);
    // Generate Form Data for request
    final data = FormData.fromMap(dto.toJson());
    // Perform POST request based on role / user_type
    return _dio.post(EndPoints.LOGIN, data: data);
  }

  Future<dynamic> signOut() async => await _dio.post(EndPoints.LOGOUT);

  Future<Response<dynamic>> timeout() async => await _dio.get(EndPoints.SLEEP);

  Future<Response<dynamic>> resendPhoneVerification(String? phone) {
    // Generate Form Data for request
    final data = FormData.fromMap(UserDTO(phone: phone).toJson());
    // Perform POST request based on role / user_type
    return _dio.post(EndPoints.RESEND_PHONE_VERIFICATION, data: data);
  }

  Future<Response<dynamic>> verifyPhoneNumber({
    required String? phone,
    required String? token,
  }) async {
    // Convert data to DTO
    final dto = UserDTO(phone: phone, token: token);
    // Generate Form Data for request
    final data = FormData.fromMap(dto.toJson());
    // Perform POST request based on role / user_type
    return _dio.post(EndPoints.CONFIRM_PHONE_VERIFICATION, data: data);
  }

  Future<Response<dynamic>> sendPasswordResetMessage({String? phone, String? email}) async {
    // Generate Form Data for request
    final data = FormData();
    if (phone != null)
      data.fields.addAll([
        MapEntry('value', '$phone'),
        const MapEntry('type', 'phone'),
      ]);
    if (email != null)
      data.fields.addAll([
        MapEntry('value', '$email'),
        const MapEntry('type', 'email'),
      ]);
    // Perform request to send password reset email
    return _dio.post(EndPoints.SEND_PASSWORD_RESET_MESSAGE, data: data);
  }

  Future<Response<dynamic>> confirmPasswordReset(UserDTO dto) async {
    // Generate Form Data for request
    final data = FormData.fromMap(dto.toJson());
    // Perform request to reset user's password
    return _dio.post(EndPoints.CONFIRM_PASSWORD_RESET, data: data);
  }

  Future<Response<dynamic>> updateProfile({
    UserDTO? dto,
    File? image,
  }) async {
    final part = image?.let(
      (it) => MultipartFile.fromFileSync(
        '${it.path}',
        filename: it.path.split(Platform.pathSeparator).last,
      ),
    );

    // Generate Form Data for request
    final _data = dto?.let((it) => FormData.fromMap(it.toJson())) ?? FormData();

    part?.let((it) => _data.files.add(MapEntry('$profileImgKey', it)));

    // Perform PATCH request to update user's profile
    return _dio.patch(EndPoints.UPDATE_USER_PROFILE, data: _data);
  }

  Future<Response<dynamic>> updatePhoneNumber(String? phone) {
    // Generate Form Data for request
    final _data = FormData.fromMap(UserDTO(phone: phone).toJson());
    // Perform PUT request to update user's profile
    return _dio.post(EndPoints.UPDATE_PHONE, data: _data);
  }

  Future<Response<dynamic>> confirmUpdatePhoneNumber({
    String? phone,
    String? token,
  }) {
    return _dio.patch(
      EndPoints.CONFIRM_UPDATE_PHONE,
      data: UserDTO(phone: phone, token: token).toJson(),
    );
  }

  Future<Response<dynamic>> updatePassword({
    required String? current,
    required String? newPassword,
    required String? confirmation,
  }) {
    // Generate Form Data for request
    final data = UserDTO(
      oldPassword: current,
      password: newPassword,
      confirmation: confirmation,
    ).toJson();
    // Perform PUT request to update user's profile
    return _dio.post(EndPoints.UPDATE_PASSWORD, data: data);
  }

  Future<Response<dynamic>> signInWithGoogle(String? token) async {
    // Generate Form Data for request
    final data = FormData.fromMap({'$socialsTokenKey': token});
    return _dio.post(EndPoints.GOOGLE_SIGNIN, data: data);
  }

  Future<Response<dynamic>> signInWithFacebook(String? token) async {
    // Generate Form Data for request
    final data = FormData.fromMap({'$socialsTokenKey': token});
    return _dio.post(EndPoints.FACEBOOK_SIGNIN, data: data);
  }

  Future<Response<dynamic>> signInWithTwitter(
    String? token,
    String? secret,
  ) async {
    // Generate Form Data for request
    final data = FormData.fromMap({
      '$socialsTokenKey': token,
      'secret': secret,
    });
    return _dio.post(EndPoints.TWITTER_SIGNIN, data: data);
  }

  Future<Response<dynamic>> signInWithApple(String? token) async {
    // Generate Form Data for request
    final data = FormData.fromMap({'$socialsTokenKey': token});
    return _dio.post(EndPoints.APPLE_SIGNIN, data: data);
  }

  Future<Response<dynamic>> updateSocialsProfile(UserDTO dto) async {
    // Perform PUT request to update user's profile
    return _dio.patch(EndPoints.UPDATE_USER_PROFILE, data: dto.toJson());
  }

  Future<Response<dynamic>> deleteAccount() async {
    // Perform request to reset user's password
    return _dio.delete(EndPoints.DELETE_USER_PROFILE);
  }

  Future<Either<AppHttpResponse, UserDTO?>> getUser([
    VoidCallback? callback,
  ]) async {
    try {
      final _result = await _dio.get(EndPoints.GET_USER);

      final _response = AppHttpResponse.fromJson(
        _result.data as Map<String, dynamic>,
      );

      return _response.response.map(
        error: (error) => left(_response.copyWith(
          response: _response.response,
          data: _result.data,
        )),
        success: (_) {
          return right(RegisteredUserDTO.fromJson(
            _result.data as Map<String, dynamic>,
          ).data);
        },
      );

      // if (_response.response.status != null)
      //   return _response.response.map(
      //     error: (error) => left(_response.copyWith(
      //       response: _response.response,
      //       data: _result.data,
      //     )),
      //     success: (_) {
      //       return right(RegisteredUserDTO.fromJson(
      //         _result.data as Map<String, dynamic>,
      //       ).data);
      //     },
      //   );

      // return right(RegisteredUserDTO.fromJson(
      //   _result.data as Map<String, dynamic>,
      // ).data);
    } on AppHttpResponse catch (e, trace) {
      return _catchBlock(e, callback, trace);
    } on AppNetworkException catch (e, trace) {
      return _catchBlock(e.asResponse(), callback, trace);
    }
  }

  Future<Either<AppHttpResponse, UserDTO?>> _catchBlock(
    AppHttpResponse e, [
    VoidCallback? callback,
    StackTrace? trace,
  ]) async {
    // If callback is not-null, call the method
    callback?.call();

    switch (e.reason) {
      case AppNetworkExceptionReason.timedOut:
      case AppNetworkExceptionReason.cancelled:
        return left(e);
      case AppNetworkExceptionReason.responseError:
      default:
        await env.flavor.fold(
          prod: () async => // Log Inknown Exceptions to Firebase Analytics
              await getIt<FirebaseCrashlytics>().recordFlutterError(
            FlutterErrorDetails(exception: e.message, stack: trace),
          ),
        );
        return left(e);
    }
  }
}
