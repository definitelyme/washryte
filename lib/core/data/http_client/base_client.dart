library base_client.dart;

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:washryte/core/data/index.dart';

/// A callback that returns a Dio response, presumably from a Dio method
/// it has called which performs an HTTP request, such as `dio.get()`,
/// `dio.post()`, etc.
typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

/// Function which takes a Dio response object and an exception and returns
/// an optional [AppHttpClientException], optionally mapping the response
/// to a custom exception.
typedef ResponseExceptionMapper = AppNetworkResponseException<DioError, dynamic>? Function<T>(Response<T>);

/// A Http client which inmplements Dio.
///
/// You can create a BaseClient instance and config it by two ways:
/// 1. create first , then config it
///
///   ```dart
///    var client = BaseClient();
///    client.options.baseUrl = "http://www.dtworkroom.com/doris/1/2.0.0/";
///    client.options.connectTimeout = 5000; //5s
///    client.options.receiveTimeout = 5000;
///    client.options.headers = {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'};
///   ```
/// 2. create and config it:
///
/// ```dart
///   var client = BaseClient(BaseOptions(
///    baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
///    connectTimeout: 5000,
///    receiveTimeout: 5000,
///    headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
///   ));
///  ```
abstract class BaseClient extends DioForNative {
  /// Create BaseClient instance with default [BaseOptions] and an optional [mapper].
  /// It is recommended that an application use only the same BaseClient singleton.
  BaseClient({required Dio client, ResponseExceptionMapper? mapper}) : super(client.options);

  /// HTTP DELETE request.
  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions);

  /// HTTP GET request.
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  /// HTTP HEAD request.
  @override
  Future<Response<T>> head<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// HTTP PATCH request.
  @override
  Future<Response<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// HTTP POST request.
  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// HTTP PUT request.
  @override
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// An instance of the dio http client
  Dio get client;

  /// If provided, this function which will be invoked when a response exception
  /// occurs, allowing the response exception to be mapped to a custom
  /// exception class which extends [AppHttpClientException].
  ResponseExceptionMapper? get mapper;

  BaseClient copyWith(ResponseExceptionMapper? mapper);

  Future<Response<T>> mapException<T>(HttpLibraryMethod<T> method) async {
    try {
      // print('Uri => ${client.options.baseUrl}');
      return await method.call();
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.cancel:
          throw AppNetworkException(reason: AppNetworkExceptionReason.timedOut, exception: e);
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          throw AppNetworkException(reason: AppNetworkExceptionReason.timedOut, exception: e);
        case DioErrorType.response:
          // For DioErrorType.response, we are guaranteed to have a
          // response object present on the exception.
          final response = e.response;
          // ignore: unnecessary_type_check
          if (response == null || response is! Response) {
            // This should never happen, judging by the current source code
            // for Dio.
            throw AppNetworkResponseException(exception: e);
          }
          throw mapper!.call(response) ??
              AppNetworkResponseException(
                exception: e,
                code: response.statusCode,
                data: response.data,
              );
        case DioErrorType.other:
        default:
          throw AppHttpClientException(exception: e);
      }
    } catch (e) {
      throw AppHttpClientException(
        exception: e is Exception ? e : Exception('Unknown exception ocurred'),
      );
    }
  }
}
