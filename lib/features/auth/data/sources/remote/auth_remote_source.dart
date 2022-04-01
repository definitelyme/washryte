library auth_remote_source.dart;

import 'dart:io';

import 'package:washryte/core/data/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRemoteDatasource {
  static const String profileImgKey = 'image';
  static const String socialsTokenKey = 'token';

  final AuthHttpClient _client;

  AuthRemoteDatasource(this._client);

  Future<Response<dynamic>> createUserAccount(UserDTO dto) async {
    // Perform POST request based on role / user_type
    return await _client.post(EndPoints.REGISTER, data: dto.toJson());
  }

  Future<Response<dynamic>> login({
    required String? email,
    required String? password,
  }) async {
    // Convert data to DTO
    final dto = UserDTO(email: email, password: password);
    // Perform POST request based on role / user_type
    return _client.post(EndPoints.LOGIN, data: dto.toJson());
  }

  Future<dynamic> signOut() async => await _client.post(EndPoints.LOGOUT);

  Future<Response<dynamic>> timeout() async => await _client.get(EndPoints.SLEEP);

  Future<Response<dynamic>> sendPasswordResetMessage(String? email) async {
    // Generate Form Data for request
    final data = FormData();
    data.fields.addAll([MapEntry('email', '$email')]);
    // Perform request to send password reset email
    return _client.post(EndPoints.SEND_PASSWORD_RESET_MESSAGE, data: data);
  }

  Future<Response<dynamic>> confirmPasswordReset(UserDTO dto) async {
    // Perform request to reset user's password
    return _client.post(EndPoints.CONFIRM_PASSWORD_RESET, data: dto.toJson());
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
    return _client.patch(EndPoints.UPDATE_USER_PROFILE, data: _data);
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
    return _client.post(EndPoints.UPDATE_PASSWORD, data: data);
  }

  Future<Response<dynamic>> signInWithGoogle(String? token) async {
    // Generate Form Data for request
    final data = FormData.fromMap({'$socialsTokenKey': token});
    return _client.post(EndPoints.GOOGLE_SIGNIN, data: data);
  }

  Future<Response<dynamic>> signInWithApple(String? token) async {
    // Generate Form Data for request
    final data = FormData.fromMap({'$socialsTokenKey': token});
    return _client.post(EndPoints.APPLE_SIGNIN, data: data);
  }

  Future<Response<dynamic>> updateSocialsProfile(UserDTO dto) async {
    // Perform PUT request to update user's profile
    return _client.patch(EndPoints.UPDATE_USER_PROFILE, data: dto.toJson());
  }

  Future<Response<dynamic>> deleteAccount() async {
    // Perform request to reset user's password
    return _client.delete(EndPoints.DELETE_USER_PROFILE);
  }

  Future<Either<AppHttpResponse, UserDTO?>> getUser([
    VoidCallback? callback,
  ]) async {
    try {
      final _result = (await getIt<AppHttpClient>().get(EndPoints.GET_USER)).data as Map<String, dynamic>;

      final _response = AppHttpResponse.fromJson(_result);

      // return left(AppHttpResponse.failure('Unauthenticated', code: 401));

      if (_result.containsKey('status')) {
        return _response.response.map(
          info: (info) => left(_response),
          error: (error) => left(_response.copyWith(response: _response.response, data: _result)),
          success: (_) => right(UserDTO.fromJson(_result)),
        );
      } else {
        return right(UserDTO.fromJson(_result));
      }
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
        await App.reportFlutterError(e, trace);
        return left(e);
    }
  }
}
