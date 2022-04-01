part of 'modules.dart';

class _HttpClients {
  static Uri get authBaseUri => Uri.https(EndPoints.AUTH_APP_DOMAIN, EndPoints.AUTH_API_ENDPOINT);

  static Uri get baseUri => Uri.https(EndPoints.APP_DOMAIN, EndPoints.API_ENDPOINT);

  static BaseOptions get _authOptions => BaseOptions(
        baseUrl: '$authBaseUri',
        contentType: 'application/json; charset=utf-8',
        headers: {
          'Accept': 'application/json',
          'contentType': 'application/json; charset=utf-8',
        },
      );

  static BaseOptions get _options => BaseOptions(
        baseUrl: '$baseUri',
        contentType: 'application/json; charset=utf-8',
        headers: {
          'Accept': 'application/json',
          'contentType': 'application/json; charset=utf-8',
        },
      );

  static List<Interceptor> get interceptors {
    var interceptors = <Interceptor>[];

    final cacheOptions = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),
      // Default.
      policy: CachePolicy.request,
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(days: 14),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended.
      allowPostMethod: false,
    );

    // Attach cache interceptor
    interceptors.add(DioCacheInterceptor(options: cacheOptions));

    // if (env.flavor == BuildFlavor.dev)
    interceptors.add(
      PrettyDioLogger(
        request: false,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100,
      ),
    );

    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final result = getIt<AccessTokenManager>().get();
        options.headers.putIfAbsent('Authorization', () => result.accessToken.getOrEmpty);
        handler.next(options);
      },
    ));

    return interceptors;
  }

  static AuthHttpClient _authClient() {
    final dio = Dio(_authOptions);

    dio.options.connectTimeout = 16000;

    dio.options.receiveTimeout = 16000;

    dio.interceptors.addAll(interceptors);

    return AuthHttpClient(
      client: dio,
      mapper: AppHttpResponse.fromDioResponse,
    );
  }

  static AppHttpClient _client() {
    final dio = Dio(_options);

    dio.options.connectTimeout = 16000;

    dio.options.receiveTimeout = 16000;

    dio.interceptors.addAll(interceptors);

    return AppHttpClient(
      client: dio,
      mapper: AppHttpResponse.fromDioResponse,
    );
  }
}
