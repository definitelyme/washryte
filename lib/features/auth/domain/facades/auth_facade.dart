library auth_facade.dart;

import 'dart:io';

import 'package:washryte/core/data/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class AuthFacade {
  Future<Either<AppHttpResponse, Option<User?>>> get currentUser;
  Stream<Either<AppHttpResponse, Option<User?>>> get onAuthStateChanges;
  Stream<Option<User?>> get onUserChanges;
  Future<Option<User?>> get user;

  Future<Option<AppHttpResponse?>> appleAuthentication([bool notify = false]);

  Future<Either<AppHttpResponse, Unit>> checkInternetConnectivity() async {
    final isConnected = (await getIt<Connectivity>().checkConnectivity()) != ConnectivityResult.none;

    if (!isConnected)
      return left(AppHttpResponse(AnyResponse.fromFailure(
        const NetworkFailure.notConnected(),
      )).copyWith(failureReason: AppNetworkExceptionReason.noInternet));

    final hasInternet = await getIt<InternetConnectionChecker>().hasConnection;

    if (isConnected && !hasInternet)
      return left(AppHttpResponse(AnyResponse.fromFailure(
        const NetworkFailure.poorInternet(),
      )).copyWith(failureReason: AppNetworkExceptionReason.noInternet));

    return right(unit);
  }

  Future<AppHttpResponse> confirmPasswordReset({
    required EmailAddress email,
    required OTPCode code,
    required Password newPassword,
    required Password confirmation,
  });

  Future<AppHttpResponse?> createAccount({
    required DisplayName fullName,
    required EmailAddress emailAddress,
    required Phone phone,
    required Password password,
    required Password confirmation,
  });

  Future<AppHttpResponse> deleteAccount();

  Future<Option<AppHttpResponse?>> googleAuthentication([bool notify = false]);

  Future<AppHttpResponse> handleFailure<R>({
    required AppHttpResponse e,
    StackTrace? trace,
    bool notify = true,
  }) async {
    switch (e.reason) {
      case AppNetworkExceptionReason.timedOut:
      case AppNetworkExceptionReason.cancelled:
        return e;
      case AppNetworkExceptionReason.responseError:
      default:
        await env.flavor.fold(
          prod: () async => // Log Inknown Exceptions to Firebase Analytics
              await getIt<FirebaseCrashlytics>().recordFlutterError(
            FlutterErrorDetails(exception: e.message, stack: trace),
          ),
        );

        // Log the User of if access token has expired
        return await e.fold(
          is401: () async {
            await signOut(notify: true);
            return e;
          },
          orElse: () async {
            // Sink all unrelated auth-failures
            // propagate any necessary data the widget tree
            if (notify) await sink(left(e));
            return e;
          },
        );
    }
  }

  Future<AppHttpResponse?> login({
    required EmailAddress email,
    required Password password,
    UserDTO? registered,
  });

  Future<Either<AppHttpResponse, Option<User?>>> retrieveAndCacheUpdatedUser({
    UserDTO? dto,
    bool shouldThrow = false,
    bool forceGetLocalCache = false,
  });

  Future<AppHttpResponse> sendPasswordResetInstructions(EmailAddress email);

  Future<void> signOut({
    bool notify = true,
    bool regular = true,
    bool google = true,
    bool apple = true,
  });

  Future<void> sink([Either<AppHttpResponse, Option<User?>> userOrFailure]);

  Future<void> sleep();

  Future<void> update(Option<User?> user);

  Future<AppHttpResponse> updatePassword({
    required Password current,
    required Password newPassword,
    required Password confirmation,
  });

  Future<AppHttpResponse> updateProfile({
    DisplayName fullName,
    EmailAddress email,
    File? image,
  });

  Future<Option<AppHttpResponse?>> updateSocialsProfile({
    DisplayName? fullName,
    EmailAddress? email,
    Username? username,
    Phone? phone,
  });
}
