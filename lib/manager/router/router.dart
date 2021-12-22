library router.dart;

import 'package:auto_route/auto_route.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/features/auth/presentation/screens/index.dart';
import 'package:washryte/features/dashboard/presentation/pages/index.dart';
import 'package:washryte/features/dashboard/presentation/screens/index.dart';
import 'package:washryte/features/onborading/screens/index.dart';
import 'package:washryte/manager/router/guards/guards.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  preferRelativeImports: false,
  routes: <AutoRoute<dynamic>>[
    AdaptiveRoute(
      initial: true,
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: SplashScreen,
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: GetStartedScreen,
      cupertinoPageTitle: 'Get Started',
      guards: [GuestGuard],
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: LoginScreen,
      cupertinoPageTitle: 'Login',
      guards: [GuestGuard],
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: SignupScreen,
      cupertinoPageTitle: 'Sign Up',
      guards: [GuestGuard],
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      fullscreenDialog: true,
      page: ForgotPasswordScreen,
      cupertinoPageTitle: 'Password Reset',
      guards: [GuestGuard],
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: SocialsAuthScreen,
      guards: [GuestGuard],
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      fullscreenDialog: true,
      maintainState: true,
      usesPathAsKey: true,
      page: PasswordResetScreen,
      cupertinoPageTitle: 'OTP',
    ),
    //
    dashboardRouter,
    //
    ...profileRoutes,
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: RequestServiceScreen,
      cupertinoPageTitle: 'Request Service',
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: TrackOrderScreen,
      cupertinoPageTitle: 'Track Orders',
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: FAQScreen,
      cupertinoPageTitle: 'FAQ',
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: ContactSupportScreen,
      cupertinoPageTitle: 'Contact Support',
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: PrivacyPolicyScreen,
      cupertinoPageTitle: 'Privacxy Policy',
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: NotificationScreen,
      cupertinoPageTitle: 'Notifications',
      guards: [AuthGuard],
    ),
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: NotConnectedScreen,
    ),
    //
    AdaptiveRoute(
      fullMatch: true,
      maintainState: true,
      usesPathAsKey: true,
      page: NoHistoryScreen,
    ),
  ],
)
class $AppRouter {}

const dashboardRouter = AutoRoute(
  path: 'bottom-navigation',
  fullMatch: true,
  page: DashboardScreen,
  maintainState: true,
  guards: [AuthGuard],
  children: [
    AutoRoute(
      path: 'home',
      name: 'HomeRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: HomePage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    //
    AutoRoute(
      path: 'insight',
      name: 'InsightRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: InsightPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    //
    AutoRoute(
      path: 'notification',
      name: 'NotificationPostRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: NotificationPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    //
    AutoRoute(
      path: 'account',
      name: 'ProfileRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: ProfilePage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ],
);

const profileRoutes = [
  AdaptiveRoute(
    fullMatch: true,
    maintainState: true,
    usesPathAsKey: true,
    page: ProfileViewScreen,
    cupertinoPageTitle: 'Profile',
    guards: [AuthGuard],
  ),
  //
  AdaptiveRoute(
    fullMatch: true,
    maintainState: true,
    usesPathAsKey: true,
    page: ProfileEditScreen,
    cupertinoPageTitle: 'Edit Profile',
    guards: [AuthGuard],
  ),
  //
  AdaptiveRoute(
    fullMatch: true,
    maintainState: true,
    usesPathAsKey: true,
    page: OrderHistoryScreen,
    cupertinoPageTitle: 'Edit Profile',
    guards: [AuthGuard],
  ),
];
