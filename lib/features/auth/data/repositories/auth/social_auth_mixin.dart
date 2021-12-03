library social_auth_mixin.dart;

import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:washryte/core/data/http_client/index.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/features/auth/data/models/index.dart';
import 'package:washryte/features/auth/data/sources/sources.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:washryte/features/auth/domain/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:dio/dio.dart' as _dio;

typedef SignInWithSocials = Future<_dio.Response<dynamic>> Function();

mixin SocialAuthMixin on AuthFacade {
  static const int FACEBOOK_IMAGE_SIZE = 600;

  AuthRemoteDatasource get remote;
  GoogleSignIn get googleSignIn;
  AuthLocalDatasource get local;
  FirebaseAnalytics get analytics;

  @override
  Future<Option<AppHttpResponse?>> googleAuthentication([bool notify = false]) async {
    // First we'll check for stable Internet connection
    final _conn = await checkInternetConnectivity();

    return await _conn.fold(
      (f) => some(f),
      (_) async {
        try {
          // Clear cached / authenticated user but do not notify UI
          if (await googleSignIn.isSignedIn()) await signOut(notify: notify, regular: false);

          // Attempt authenticating user with google credentials
          var account = await googleSignIn.signIn();
          // If null, => user cancelled authentication
          if (account == null) throw FailureResponse.aborted();

          // get authentication details [idToken], [accessToken]
          final _auth = await account.authentication;

          return _authenticateUser(
            () => remote.signInWithGoogle(_auth.accessToken),
            provider: AuthProvider.google,
          );
        } on AppHttpResponse catch (e) {
          return some(e);
        } on AppNetworkException catch (e) {
          return some(e.asResponse());
        } on Failure catch (e) {
          return some(AppHttpResponse.failure(e.message));
        } on PlatformException catch (e) {
          return some(AppHttpResponse(AnyResponse.fromFailure(
            FailureResponse.unknown(message: e.message),
          )));
        }
      },
    );
  }

  @override
  Future<Option<AppHttpResponse?>> appleAuthentication([bool notify = false]) async {
    try {
      return some(AppHttpResponse(AnyResponse.fromFailure(
        FailureResponse.unImplemented('Signin with Apple not implemented!'),
      )));
    } on AppHttpResponse catch (e) {
      log.e(e);
      return some(e);
    } on PlatformException catch (e) {
      log.e(e);
      return some(AppHttpResponse(AnyResponse.fromFailure(
        FailureResponse.unknown(message: e.message),
      )));
    }
  }

  Future<Option<AppHttpResponse?>> _authenticateUser(
    SignInWithSocials callable, {
    required AuthProvider provider,
  }) async {
    final response = await callable.call();

    // cache access token
    await local.cacheUserAccessToken(response.data);

    // Get Authenticated Rider account
    final _rider = await remote.getUser();

    return _rider.fold(
      (failure) async {
        final _data = failure.data as Map<String, dynamic>;
        final _socialDto = SocialUserDTO.fromJson(_data);

        // Log Firebase Analytics Login event
        await analytics.logLogin(loginMethod: 'google');

        await retrieveAndCacheUpdatedUser(dto: _socialDto.dto);

        await sink(left(failure));

        return some(failure);
      },
      (dto) async {
        // Log Firebase Analytics Login event
        await analytics.logLogin(loginMethod: 'google');

        await sink(right(optionOf(dto?.domain)));

        return none();
      },
    );
  }
}
