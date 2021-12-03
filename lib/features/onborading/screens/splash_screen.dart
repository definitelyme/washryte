library splash_screen.dart;

import 'package:async/async.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/onborading/screens/index.dart';
import 'package:washryte/manager/settings/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

class SplashScreen extends StatefulWidget with AutoRouteWrapper {
  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final AsyncMemoizer<dynamic> _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  void navigateUser(BuildContext c, bool isFirstLaunch) {
    final isAuthenticated = c.read<AuthWatcherCubit>().state.isAuthenticated;

    if (!isFirstLaunch) {
      if (isAuthenticated)
        navigator.replaceAll([const DashboardRoute()]);
      else
        navigator.replaceAll([const GetStartedRoute()]);
    } else {
      navigator.replaceAll([const GetStartedRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Palette.accentColor),
              ),
            ),
            //
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(child: Image.asset(AppAssets.logo)),
            ),
            //
            FutureBuilder(
              future: _memoizer.runOnce(
                () => Future.delayed(
                  env.splashDuration,
                  () async {
                    await BlocProvider.of<AuthWatcherCubit>(App.context).subscribeToAuthChanges(
                      (either) => either.fold(
                        (failure) => failure.fold(
                          orElse: () => null,
                          is401: () => navigateToLogin(),
                          is41101: () => navigateToSocials(),
                        ),
                        (option) => option.fold(
                          () {
                            if (navigator.current.name == DashboardRoute.name)
                              navigator.replaceAll([const GetStartedRoute()]);
                            else {
                              final isFirstAppLaunch = App.context.read<GlobalAppPreferenceCubit>().isFirstAppLaunch;

                              navigateUser(App.context, isFirstAppLaunch);
                            }
                          },
                          (_) => navigator.replaceAll([const DashboardRoute()]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              builder: (_, __) => Positioned(
                left: 0.0,
                right: 0.0,
                bottom: App.height * 0.05,
                child: BlocBuilder<AuthWatcherCubit, AuthWatcherState>(
                  builder: (c, s) => Visibility(
                    visible: s.isLoading,
                    child: const SplashPositionedLoader(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
