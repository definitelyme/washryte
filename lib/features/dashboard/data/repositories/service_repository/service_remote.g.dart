// GENERATED CODE - DO NOT MODIFY BY HAND

part of service_remote.dart;

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ServiceRemote implements ServiceRemote {
  _ServiceRemote(this._dio, {this.baseUrl});

  final AppHttpClient _dio;

  String? baseUrl;

  @override
  Future<ServiceRequestDTO> store(dto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(await compute(serializeServiceRequestDTO, dto));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ServiceRequestDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/orders',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await compute(deserializeServiceRequestDTO, _result.data!);
    return value;
  }

  @override
  Future<ServiceRequestDTO> fundWallet(amount) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'amount': amount};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ServiceRequestDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wallet/deposit',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await compute(deserializeServiceRequestDTO, _result.data!);
    return value;
  }

  @override
  Future<ServiceRequestDTO> show(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ServiceRequestDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/orders/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await compute(deserializeServiceRequestDTO, _result.data!);
    return value;
  }

  @override
  Future<ServiceRequestListDTO> activeRequests({page, perPage}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ServiceRequestListDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/orders/track',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await compute(deserializeServiceRequestListDTO, _result.data!);
    return value;
  }

  @override
  Future<ServiceRequestListDTO> history(
      {page, perPage, dates, selectedDate}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage,
      r'dates': dates,
      r'date_from': await compute(serializeDateTime, selectedDate)
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ServiceRequestListDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/orders/history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await compute(deserializeServiceRequestListDTO, _result.data!);
    return value;
  }

  @override
  Future<AppNotificationListDTO> notifications({page, perPage}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AppNotificationListDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/notifications',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await compute(deserializeAppNotificationListDTO, _result.data!);
    return value;
  }

  @override
  Future<AppHttpResponse> pay(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AppHttpResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/orders/${id}/pay',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await compute(deserializeAppHttpResponse, _result.data!);
    return value;
  }

  @override
  Future<AppHttpResponse> cancel(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AppHttpResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/orders/${id}/cancel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await compute(deserializeAppHttpResponse, _result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
