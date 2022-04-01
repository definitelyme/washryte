library social_auth_mixin.dart;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:washryte/core/data/http_client/index.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/features/auth/data/models/index.dart';
import 'package:washryte/features/auth/data/sources/sources.dart';
import 'package:washryte/features/auth/domain/index.dart';

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
    final _conn = await checkInternetConnectivity();

    return await _conn.fold(
      (f) => some(f),
      (_) async {
        try {
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
          );

          // Attempt to authenticate the user with apple credentials
          return _authenticateUser(
            () => remote.signInWithApple(credential.identityToken),
            provider: AuthProvider.apple,
          );
        } on AppHttpResponse catch (e) {
          return some(e);
        } on AppNetworkException catch (e) {
          return some(e.asResponse());
        } on SignInWithAppleNotSupportedException catch (e) {
          return some(AppHttpResponse.failure('${e.message}'));
        } on SignInWithAppleException catch (_) {
          return some(AppHttpResponse(AnyResponse.fromFailure(FailureResponse.aborted())));
        }
      },
    );
  }

  Future<Option<AppHttpResponse?>> _authenticateUser(
    SignInWithSocials callable, {
    required AuthProvider provider,
  }) async {
    final result = await callable.call();

    final response = SocialUserDTO.fromJson(result.data as Map<String, dynamic>);

    switch (response.status) {
      case 'success':
        await local.cacheUserAccessToken(result.data);

        // Get Authenticated User account
        final _user = await remote.getUser();

        return _user.fold(
          (e) async {
            final _data = e.data as Map<String, dynamic>;
            final dto = SocialUserDTO.fromJson(_data);

            await retrieveAndCacheUpdatedUser(dto: dto.dto);

            await sink(left(e));

            return some(e);
          },
          (dto) async {
            // Log Firebase Analytics Login event
            await analytics.logLogin(loginMethod: provider.name);

            await sink(right(optionOf(dto?.domain)));

            return none();
          },
        );
      case 'error':
      case 'failure':
      default:
        final value = AppHttpResponse.fromDioResponse(result);
        return optionOf(value);
    }
  }
}
