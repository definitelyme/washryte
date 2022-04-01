import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/utils/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;

    if (context != null) {
      final authenticated = BlocProvider.of<AuthWatcherCubit>(context).state.isAuthenticated;

      if (authenticated)
        resolver.next();
      else {
        WidgetsBinding.instance!.endOfFrame.then((_) {
          if (App.currentRoute != LoginRoute.name) navigator.replaceAll([const LoginRoute()]);
        });
      }
    } else
      resolver.next();
  }
}
