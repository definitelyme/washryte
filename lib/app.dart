library app.dart;

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:washryte/core/data/http_client/index.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/manager/settings/index.dart';
import 'package:washryte/manager/theme/theme.dart';
import 'package:washryte/utils/utils.dart';

class Washryte extends StatelessWidget {
  /// This is the entry point for Washryte App
  const Washryte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _router = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<AuthWatcherCubit>()),
        BlocProvider(create: (_) => getIt<TabNavigationCubit>()),
        BlocProvider(create: (_) => getIt<GlobalAppPreferenceCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthWatcherCubit, AuthWatcherState>(
            listenWhen: (p, c) =>
                p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
                (c.status.getOrElse(() => null) != null &&
                    (c.status.getOrElse(() => null)!.response.maybeMap(
                          error: (f) => f.fold(orElse: () => false),
                          orElse: () => false,
                        ))),
            listener: (c, s) => s.status.fold(
              () => null,
              (th) => th?.response.mapOrNull(
                error: (f) => th.reason.fold(timeoutNoInternet: () async {
                  await ToastManager.cancel();
                  await ToastManager.long('${f.message}');
                  return;
                }),
              ),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, AppTheme>(
          builder: (context, app) => PlatformApp.router(
            title: Const.appName.capitalizeFirst(),
            debugShowCheckedModeBanner: false,
            color: Palette.accentColor,
            material: (_, __) => MaterialAppRouterData(
              theme: app.themeData(),
              darkTheme: AppTheme.dark().themeData(),
              themeMode: ThemeMode.system,
            ),
            cupertino: (c, __) => CupertinoAppRouterData(
              theme: app.cupertinoThemeData(c),
              color: Palette.accentColor,
            ),
            localizationsDelegates: [
              RefreshLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            routeInformationParser: _router.defaultRouteParser(),
            routerDelegate: AutoRouterDelegate(
              _router,
              navigatorObservers: () => <NavigatorObserver>[
                // Register the Firebase Analytics observer
                if (env.flavor == BuildFlavor.prod) FirebaseAnalyticsObserver(analytics: getIt<FirebaseAnalytics>()),
              ],
            ),
            builder: (context, widget) => Utils.setup(
              context,
              _router,
              ScreenUtilInit(designSize: const Size(375, 812), builder: () => widget!),
            ),
          ),
        ),
      ),
    );
  }
}
