library modules.dart;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:washryte/core/data/index.dart';
import 'package:washryte/features/auth/data/repositories/repos.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/manager/router/guards/guards.dart';
import 'package:washryte/utils/utils.dart';

part 'http_client_module.part.dart';

@module
abstract class Modules {
  @lazySingleton
  AccessTokenManager get accessTokenManager => AccessTokenManager();

  @preResolve
  Future<AppDatabase> get database async => await $FloorAppDatabase.databaseBuilder(Const.database).build();

  @lazySingleton
  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance..logAppOpen();

  @preResolve
  Future<FirebaseApp> get firebaseApp => Firebase.initializeApp();

  @lazySingleton
  FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );

  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  @singleton
  AppRouter get router => AppRouter(authGuard: AuthGuard(), guestGuard: GuestGuard());

  @lazySingleton
  SweetSheet get sweetSheet => SweetSheet();
}

@module
abstract class ServiceModules {
  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker();

  @lazySingleton
  Connectivity get connectionStatus => Connectivity();

  @singleton
  Dio get dio => _HttpClients._clientv2();

  @singleton
  AppHttpClient get httpClient => _HttpClients._clientv2();
}
