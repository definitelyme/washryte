library splash_screen.dart;

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/onborading/screens/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render SplashScreen.
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final AsyncMemoizer<dynamic> _memoizer = AsyncMemoizer();

  static void navigateIfNotAuthenticated() {
    if (navigator.current.name == DashboardRoute.name)
      navigator.replaceAll([const LoginRoute()]);
    else {
      _navigateUser(App.context);
    }
  }

  static void _navigateUser(BuildContext c) {
    final option = c.read<AuthWatcherCubit>().state.status;
    final _authRoutes = [LoginRoute.name, SignupRoute.name, ForgotPasswordRoute.name];

    option.fold(
      () => null,
      (o) {
        if (o != null) {
          if (!_authRoutes.contains(App.currentRoute)) navigator.replaceAll([const LoginRoute()]);
        } else {
          if (App.currentRoute != DashboardRoute.name) navigator.replaceAll([const DashboardRoute()]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: Palette.accentColor,
      body: Center(
        child: FutureBuilder(
          future: _memoizer.runOnce(
            () => Future.delayed(
              env.splashDuration,
              () async {
                await BlocProvider.of<AuthWatcherCubit>(App.context).subscribeToAuthChanges(
                  (either) => either.fold(
                    (failure) => SplashScreen.navigateIfNotAuthenticated(),
                    (option) => WidgetsBinding.instance!.addPostFrameCallback(
                      (_) {
                        if (App.currentRoute != DashboardRoute.name) navigator.replaceAll([const DashboardRoute()]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          builder: (_, snapshot) => Stack(
            children: [
              Center(
                child: ImageBox.asset(
                  photo: AppAssets.logo,
                  elevation: 0.0,
                  width: 0.4.w,
                  borderRadius: BorderRadius.zero,
                  useDefaultRadius: false,
                  fit: BoxFit.contain,
                ),
              ),
              //
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: App.height * 0.05,
                child: BlocBuilder<AuthWatcherCubit, AuthWatcherState>(
                  builder: (c, s) => Visibility(
                    visible: s.isLoading,
                    child: const SplashPositionedLoader(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
