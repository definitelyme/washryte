import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/utils/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authenticated = BlocProvider.of<AuthWatcherCubit>(router.navigatorKey.currentContext!).state.isAuthenticated;

    if (authenticated)
      await router.popAndPush(const DashboardRoute());
    else
      resolver.next(true);
  }
}
