library auth_facade.dart;

import 'dart:io';

import 'package:washryte/core/data/index.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/response/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class AuthFacade {
  Future<Either<AppHttpResponse, Option<User?>>> get currentUser;
  Stream<Either<AppHttpResponse, Option<User?>>> get onAuthStateChanges;
  Stream<Option<User?>> get onUserChanges;
  Future<Option<User?>> get user;

  Future<void> sink([Either<AppHttpResponse, Option<User?>> userOrFailure]);

  Future<void> update(Option<User?> user);

  Future<AppHttpResponse?> login({
    required EmailAddress email,
    required Password password,
    UserDTO? registered,
  });

  Future<AppHttpResponse?> createAccount({
    required DisplayName firstName,
    required DisplayName lastName,
    required EmailAddress emailAddress,
    required Password password,
    required Phone phone,
  });

  Future<AppHttpResponse> updateProfile({
    DisplayName firstName,
    DisplayName lastName,
    EmailAddress email,
    File? image,
  });

  Future<AppHttpResponse> updatePhone(Phone phone);

  Future<AppHttpResponse> confirmUpdatePhone({
    required Phone phone,
    required OTPCode code,
  });

  Future<AppHttpResponse> updatePassword({
    required Password current,
    required Password newPassword,
    required Password confirmation,
  });

  Future<AppHttpResponse> resendVerificationEmail(Phone phone);

  Future<AppHttpResponse> verifyPhoneNumber({
    required Phone phone,
    required OTPCode token,
  });

  Future<AppHttpResponse> sendPasswordResetInstructions({
    Phone? phone,
    EmailAddress? email,
  });

  Future<AppHttpResponse> confirmPasswordReset({
    required Phone phone,
    required OTPCode code,
    required Password newPassword,
    required Password confirmation,
  });

  Future<Option<AppHttpResponse?>> googleAuthentication([bool notify = false]);

  Future<Option<AppHttpResponse?>> appleAuthentication([bool notify = false]);

  Future<Option<AppHttpResponse?>> updateSocialsProfile({
    DisplayName? firstName,
    DisplayName? lastName,
    EmailAddress? email,
    Username? username,
    Phone? phone,
  });

  Future<void> signOut({
    bool notify = true,
    bool regular = true,
    bool google = true,
    bool apple = true,
  });

  Future<AppHttpResponse> deleteAccount();

  Future<void> sleep();

  Future<Either<AppHttpResponse, Option<User?>>> retrieveAndCacheUpdatedUser({
    UserDTO? dto,
    bool shouldThrow = false,
    bool forceGetLocalCache = false,
  });

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
}
