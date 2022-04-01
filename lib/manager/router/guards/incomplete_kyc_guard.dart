library incomplete_kyc_guard.dart;

import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/utils/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncompleteKYCGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final s = BlocProvider.of<AuthWatcherCubit>(App.context).state.status;

    s.fold(
      () => resolver.next(true),
      (error) => error?.fold(
        is41101: () {
          if (App.currentRoute != SocialsAuthRoute.name) navigator.replaceAll([const SocialsAuthRoute()]);
        },
        orElse: () => resolver.next(true),
      ),
    );
  }
}
