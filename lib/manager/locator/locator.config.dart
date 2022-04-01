// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity_plus/connectivity_plus.dart' as _i8;
import 'package:firebase_analytics/firebase_analytics.dart' as _i9;
import 'package:firebase_core/firebase_core.dart' as _i10;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i11;
import 'package:flutter_paystack/flutter_paystack.dart' as _i15;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i14;
import 'package:shared_preferences/shared_preferences.dart' as _i19;
import 'package:washryte/core/data/index.dart' as _i4;
import 'package:washryte/core/data/sources/remote/utilities/utilities_remote.dart'
    as _i22;
import 'package:washryte/features/auth/data/repositories/auth/auth_facade_impl.dart'
    as _i26;
import 'package:washryte/features/auth/data/repositories/repos.dart' as _i3;
import 'package:washryte/features/auth/data/sources/local/auth_local_source.dart'
    as _i6;
import 'package:washryte/features/auth/data/sources/remote/auth_remote_source.dart'
    as _i7;
import 'package:washryte/features/auth/domain/index.dart' as _i25;
import 'package:washryte/features/auth/presentation/managers/auth_cubit/auth_cubit.dart'
    as _i29;
import 'package:washryte/features/auth/presentation/managers/watcher/auth_watcher_cubit.dart'
    as _i27;
import 'package:washryte/features/dashboard/data/repositories/places_repository/places_repository.dart'
    as _i16;
import 'package:washryte/features/dashboard/data/repositories/service_repository/service_remote.dart'
    as _i17;
import 'package:washryte/features/dashboard/data/repositories/service_repository/service_repository.dart'
    as _i18;
import 'package:washryte/features/dashboard/data/repositories/utilities_repository/utilities_repository.dart'
    as _i23;
import 'package:washryte/features/dashboard/presentation/managers/request/request_cubit.dart'
    as _i28;
import 'package:washryte/features/dashboard/presentation/managers/tab_navigation/tab_navigation_cubit.dart'
    as _i20;
import 'package:washryte/manager/locator/modules/modules.dart' as _i30;
import 'package:washryte/manager/settings/external/preference_repository.dart'
    as _i24;
import 'package:washryte/manager/settings/manager/global_app_preference_cubit.dart'
    as _i12;
import 'package:washryte/manager/theme/manager/theme_cubit.dart' as _i21;
import 'package:washryte/utils/utils.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  Future<_i1.GetIt> $initGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final modules = _$Modules();
    final serviceModules = _$ServiceModules();
    gh.lazySingleton<_i3.AccessTokenManager>(() => modules.accessTokenManager);
    await gh.factoryAsync<_i4.AppDatabase>(() => modules.database,
        preResolve: true);
    gh.singleton<_i4.AppHttpClient>(serviceModules.httpClient);
    gh.singleton<_i5.AppRouter>(modules.router);
    gh.singleton<_i4.AuthHttpClient>(serviceModules.authHttpClient);
    gh.singleton<_i6.AuthLocalDatasource>(_i6.AuthLocalDatasource(
        get<_i3.AccessTokenManager>(), get<_i4.AppDatabase>()));
    gh.singleton<_i7.AuthRemoteDatasource>(
        _i7.AuthRemoteDatasource(get<_i4.AuthHttpClient>()));
    gh.lazySingleton<_i8.Connectivity>(() => serviceModules.connectionStatus);
    gh.lazySingleton<_i9.FirebaseAnalytics>(() => modules.firebaseAnalytics);
    await gh.factoryAsync<_i10.FirebaseApp>(() => modules.firebaseApp,
        preResolve: true);
    gh.lazySingleton<_i11.FirebaseCrashlytics>(
        () => modules.firebaseCrashlytics);
    gh.singleton<_i12.GlobalAppPreferenceCubit>(
        _i12.GlobalAppPreferenceCubit());
    gh.lazySingleton<_i13.GoogleSignIn>(() => modules.googleSignIn);
    gh.lazySingleton<_i14.InternetConnectionChecker>(
        () => serviceModules.connectionChecker);
    gh.lazySingleton<_i15.PaystackPlugin>(() => modules.paystackInit);
    gh.lazySingleton<_i16.PlacesRepository>(
        () => _i16.PlacesRepository(get<_i4.AppHttpClient>()));
    gh.lazySingleton<_i17.ServiceRemote>(
        () => _i17.ServiceRemote(get<_i4.AppHttpClient>()));
    gh.lazySingleton<_i18.ServiceRepository>(() => _i18.ServiceRepository(
        get<_i14.InternetConnectionChecker>(),
        get<_i8.Connectivity>(),
        get<_i17.ServiceRemote>()));
    await gh.factoryAsync<_i19.SharedPreferences>(() => modules.preferences,
        preResolve: true);
    gh.factory<_i20.TabNavigationCubit>(() => _i20.TabNavigationCubit());
    gh.factory<_i21.ThemeCubit>(() => _i21.ThemeCubit());
    gh.lazySingleton<_i22.UtilitiesRemote>(
        () => _i22.UtilitiesRemote(get<_i4.AppHttpClient>()));
    gh.lazySingleton<_i23.UtilitiesRepository>(() => _i23.UtilitiesRepository(
        get<_i14.InternetConnectionChecker>(),
        get<_i8.Connectivity>(),
        get<_i22.UtilitiesRemote>()));
    gh.singleton<_i24.PreferenceRepository>(
        _i24.PreferenceRepository(get<_i19.SharedPreferences>()));
    gh.lazySingleton<_i25.AuthFacade>(() => _i26.AuthFacadeImpl(
        get<_i7.AuthRemoteDatasource>(),
        get<_i6.AuthLocalDatasource>(),
        get<_i13.GoogleSignIn>(),
        get<_i9.FirebaseAnalytics>(),
        get<_i24.PreferenceRepository>()));
    gh.factory<_i27.AuthWatcherCubit>(() => _i27.AuthWatcherCubit(
        get<_i25.AuthFacade>(), get<_i24.PreferenceRepository>()));
    gh.factory<_i28.RequestCubit>(() => _i28.RequestCubit(
        get<_i18.ServiceRepository>(),
        get<_i15.PaystackPlugin>(),
        get<_i9.FirebaseAnalytics>(),
        get<_i25.AuthFacade>()));
    gh.factory<_i29.AuthCubit>(() => _i29.AuthCubit(get<_i25.AuthFacade>()));
    return this;
  }
}

class _$Modules extends _i30.Modules {}

class _$ServiceModules extends _i30.ServiceModules {}
