library app_http_response.dart;

import 'package:dartz/dartz.dart';
import 'package:washryte/core/data/http_client/index.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/response/response.dart';
import 'package:washryte/features/auth/domain/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/manager/serializer/serializers.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:dio/dio.dart' as _d;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washryte/utils/utils.dart';

part 'app_http_response.gen.dart';
part 'app_http_response.freezed.dart';

@freezed
@immutable
class AppHttpResponse extends AppNetworkResponseException<DioError, dynamic> with _$AppHttpResponse implements Failure, Response {
  const factory AppHttpResponse(
    @AnyResponseSerializer() AnyResponse response, {
    @JsonKey(ignore: true) dynamic data,
    @JsonKey(ignore: true) DioError? exception,
    @JsonKey(ignore: true) AppNetworkExceptionReason? failureReason,
  }) = _AppHttpResponse;

  const AppHttpResponse._();

  /// Maps the incoming Json to a Data Transfer Object (DTO).
  factory AppHttpResponse.fromJson(Map<String, dynamic> json) => _$AppHttpResponseFromJson(json);

  factory AppHttpResponse.successful(
    String? message, {
    bool pop = true,
    String? uuid,
  }) =>
      AppHttpResponse(
        AnyResponse.success(
          pop: pop,
          uuid: uuid,
          messageTxt: message ?? 'Successful!',
        ),
      );

  factory AppHttpResponse.failure(String? message, {int? code}) => AppHttpResponse(
        AnyResponse.error(
          code: code,
          messageTxt: message ?? 'Whoops! An error occurred.',
        ),
      );

  @override
  int? get code => response.map(error: (e) => e.code, success: (_) => null);

  @override
  AppNetworkExceptionReason get reason => failureReason ?? super.reason;

  @override
  bool get hasData => data != null;

  @override
  String? get details => response.map(error: (e) => null, success: (s) => s.details);

  @override
  String? get error => response.map(error: (e) => e.error, success: (_) => null);

  @override
  ServerFieldErrors? get errors => response.map(error: (e) => e.errors, success: (_) => null);

  @override
  String get message => response.message;

  @override
  bool get show => response.map(error: (e) => true, success: (s) => s.show);

  @override
  String? get status => response.status;

  @override
  String? get uuid => response.map(error: (e) => null, success: (s) => s.uuid);

  static AppHttpResponse? fromDioResponse<T>(_d.Response<T>? response) {
    final data = response?.data;
    if (data != null && data is Map<String, dynamic>) {
      final _value = AppHttpResponse.fromJson(data);

      final _return = _value.copyWith(
        data: data,
        response: _value.response.maybeMap(
          error: (e) => AnyResponse.error(
            code: e.code ?? response?.statusCode,
            messageTxt: e.message,
            errors: e.errors,
            details: response?.data?.toString(),
            error: e.error,
            status: e.status,
            exception: e.exception,
            pop: e.pop,
          ),
          orElse: () => _value.response,
        ),
      );

      _return.fold(
        is401: () => getIt<AuthFacade>().sink(left(_return)),
        orElse: () => null,
      );

      return _return;
    }
    return null;
  }
}
