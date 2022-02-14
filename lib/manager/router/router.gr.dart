// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:async' as _i10;

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/material.dart' as _i7;
import 'package:washryte/core/presentation/index.dart' as _i4;
import 'package:washryte/features/auth/presentation/screens/index.dart' as _i2;
import 'package:washryte/features/dashboard/presentation/pages/index.dart'
    as _i6;
import 'package:washryte/features/dashboard/presentation/screens/index.dart'
    as _i3;
import 'package:washryte/features/onborading/screens/index.dart' as _i1;
import 'package:washryte/manager/router/guards/guards.dart' as _i8;

class AppRouter extends _i5.RootStackRouter {
  AppRouter(
      {_i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
      required this.guestGuard,
      required this.authGuard})
      : super(navigatorKey);

  final _i8.GuestGuard guestGuard;

  final _i8.AuthGuard authGuard;

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.SplashScreen());
    },
    GetStartedRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i1.GetStartedScreen(),
          title: 'Get Started');
    },
    LoginRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen(), title: 'Login');
    },
    SignupRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i2.SignupScreen(),
          title: 'Sign Up');
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i2.ForgotPasswordScreen(),
          fullscreenDialog: true,
          title: 'Password Reset');
    },
    SocialsAuthRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.SocialsAuthScreen());
    },
    PasswordResetRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i2.PasswordResetScreen(),
          fullscreenDialog: true,
          title: 'OTP');
    },
    DashboardRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.DashboardScreen());
    },
    ProfileViewRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.ProfileViewScreen(),
          title: 'Profile');
    },
    ProfileEditRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.ProfileEditScreen(),
          title: 'Edit Profile');
    },
    OrderHistoryRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.OrderHistoryScreen(),
          title: 'Edit Profile');
    },
    RequestServiceRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.RequestServiceScreen(),
          title: 'Request Service');
    },
    TrackOrderRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.TrackOrderScreen(),
          title: 'Track Orders');
    },
    FAQRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.FAQScreen(), title: 'FAQ');
    },
    ContactSupportRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.ContactSupportScreen(),
          title: 'Contact Support');
    },
    PrivacyPolicyRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.PrivacyPolicyScreen(),
          title: 'Privacxy Policy');
    },
    NotificationRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.NotificationScreen(),
          title: 'Notifications');
    },
    NotConnectedRoute.name: (routeData) {
      final args = routeData.argsAs<NotConnectedRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.NotConnectedScreen(key: args.key, future: args.future));
    },
    NoHistoryRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.NoHistoryScreen());
    },
    HomeRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    InsightRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    NotificationPostRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ProfileRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    HomePage.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.HomePage());
    },
    InsightPage.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.InsightPage());
    },
    NotificationPage.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.NotificationPage());
    },
    ProfilePage.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.ProfilePage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(SplashRoute.name,
            path: '/', fullMatch: true, usesPathAsKey: true),
        _i5.RouteConfig(GetStartedRoute.name,
            path: '/get-started-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [guestGuard]),
        _i5.RouteConfig(LoginRoute.name,
            path: '/login-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [guestGuard]),
        _i5.RouteConfig(SignupRoute.name,
            path: '/signup-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [guestGuard]),
        _i5.RouteConfig(ForgotPasswordRoute.name,
            path: '/forgot-password-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [guestGuard]),
        _i5.RouteConfig(SocialsAuthRoute.name,
            path: '/socials-auth-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [guestGuard]),
        _i5.RouteConfig(PasswordResetRoute.name,
            path: '/password-reset-screen',
            fullMatch: true,
            usesPathAsKey: true),
        _i5.RouteConfig(DashboardRoute.name,
            path: 'bottom-navigation',
            fullMatch: true,
            guards: [
              authGuard
            ],
            children: [
              _i5.RouteConfig(HomeRouter.name,
                  path: 'home',
                  parent: DashboardRoute.name,
                  children: [
                    _i5.RouteConfig(HomePage.name,
                        path: '', parent: HomeRouter.name),
                    _i5.RouteConfig('*#redirect',
                        path: '*',
                        parent: HomeRouter.name,
                        redirectTo: '',
                        fullMatch: true)
                  ]),
              _i5.RouteConfig(InsightRouter.name,
                  path: 'insight',
                  parent: DashboardRoute.name,
                  children: [
                    _i5.RouteConfig(InsightPage.name,
                        path: '', parent: InsightRouter.name),
                    _i5.RouteConfig('*#redirect',
                        path: '*',
                        parent: InsightRouter.name,
                        redirectTo: '',
                        fullMatch: true)
                  ]),
              _i5.RouteConfig(NotificationPostRouter.name,
                  path: 'notification',
                  parent: DashboardRoute.name,
                  children: [
                    _i5.RouteConfig(NotificationPage.name,
                        path: '', parent: NotificationPostRouter.name),
                    _i5.RouteConfig('*#redirect',
                        path: '*',
                        parent: NotificationPostRouter.name,
                        redirectTo: '',
                        fullMatch: true)
                  ]),
              _i5.RouteConfig(ProfileRouter.name,
                  path: 'account',
                  parent: DashboardRoute.name,
                  children: [
                    _i5.RouteConfig(ProfilePage.name,
                        path: '', parent: ProfileRouter.name),
                    _i5.RouteConfig('*#redirect',
                        path: '*',
                        parent: ProfileRouter.name,
                        redirectTo: '',
                        fullMatch: true)
                  ])
            ]),
        _i5.RouteConfig(ProfileViewRoute.name,
            path: '/profile-view-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [authGuard]),
        _i5.RouteConfig(ProfileEditRoute.name,
            path: '/profile-edit-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [authGuard]),
        _i5.RouteConfig(OrderHistoryRoute.name,
            path: '/order-history-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [authGuard]),
        _i5.RouteConfig(RequestServiceRoute.name,
            path: '/request-service-screen',
            fullMatch: true,
            usesPathAsKey: true),
        _i5.RouteConfig(TrackOrderRoute.name,
            path: '/track-order-screen', fullMatch: true, usesPathAsKey: true),
        _i5.RouteConfig(FAQRoute.name,
            path: '/f-aq-screen', fullMatch: true, usesPathAsKey: true),
        _i5.RouteConfig(ContactSupportRoute.name,
            path: '/contact-support-screen',
            fullMatch: true,
            usesPathAsKey: true),
        _i5.RouteConfig(PrivacyPolicyRoute.name,
            path: '/privacy-policy-screen',
            fullMatch: true,
            usesPathAsKey: true),
        _i5.RouteConfig(NotificationRoute.name,
            path: '/notification-screen',
            fullMatch: true,
            usesPathAsKey: true,
            guards: [authGuard]),
        _i5.RouteConfig(NotConnectedRoute.name,
            path: '/not-connected-screen',
            fullMatch: true,
            usesPathAsKey: true),
        _i5.RouteConfig(NoHistoryRoute.name,
            path: '/no-history-screen', fullMatch: true, usesPathAsKey: true)
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.GetStartedScreen]
class GetStartedRoute extends _i5.PageRouteInfo<void> {
  const GetStartedRoute()
      : super(GetStartedRoute.name, path: '/get-started-screen');

  static const String name = 'GetStartedRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-screen');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.SignupScreen]
class SignupRoute extends _i5.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: '/signup-screen');

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i2.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i5.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: '/forgot-password-screen');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i2.SocialsAuthScreen]
class SocialsAuthRoute extends _i5.PageRouteInfo<void> {
  const SocialsAuthRoute()
      : super(SocialsAuthRoute.name, path: '/socials-auth-screen');

  static const String name = 'SocialsAuthRoute';
}

/// generated route for
/// [_i2.PasswordResetScreen]
class PasswordResetRoute extends _i5.PageRouteInfo<void> {
  const PasswordResetRoute()
      : super(PasswordResetRoute.name, path: '/password-reset-screen');

  static const String name = 'PasswordResetRoute';
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute({List<_i5.PageRouteInfo>? children})
      : super(DashboardRoute.name,
            path: 'bottom-navigation', initialChildren: children);

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i3.ProfileViewScreen]
class ProfileViewRoute extends _i5.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(ProfileViewRoute.name, path: '/profile-view-screen');

  static const String name = 'ProfileViewRoute';
}

/// generated route for
/// [_i3.ProfileEditScreen]
class ProfileEditRoute extends _i5.PageRouteInfo<void> {
  const ProfileEditRoute()
      : super(ProfileEditRoute.name, path: '/profile-edit-screen');

  static const String name = 'ProfileEditRoute';
}

/// generated route for
/// [_i3.OrderHistoryScreen]
class OrderHistoryRoute extends _i5.PageRouteInfo<void> {
  const OrderHistoryRoute()
      : super(OrderHistoryRoute.name, path: '/order-history-screen');

  static const String name = 'OrderHistoryRoute';
}

/// generated route for
/// [_i3.RequestServiceScreen]
class RequestServiceRoute extends _i5.PageRouteInfo<void> {
  const RequestServiceRoute()
      : super(RequestServiceRoute.name, path: '/request-service-screen');

  static const String name = 'RequestServiceRoute';
}

/// generated route for
/// [_i3.TrackOrderScreen]
class TrackOrderRoute extends _i5.PageRouteInfo<void> {
  const TrackOrderRoute()
      : super(TrackOrderRoute.name, path: '/track-order-screen');

  static const String name = 'TrackOrderRoute';
}

/// generated route for
/// [_i3.FAQScreen]
class FAQRoute extends _i5.PageRouteInfo<void> {
  const FAQRoute() : super(FAQRoute.name, path: '/f-aq-screen');

  static const String name = 'FAQRoute';
}

/// generated route for
/// [_i3.ContactSupportScreen]
class ContactSupportRoute extends _i5.PageRouteInfo<void> {
  const ContactSupportRoute()
      : super(ContactSupportRoute.name, path: '/contact-support-screen');

  static const String name = 'ContactSupportRoute';
}

/// generated route for
/// [_i3.PrivacyPolicyScreen]
class PrivacyPolicyRoute extends _i5.PageRouteInfo<void> {
  const PrivacyPolicyRoute()
      : super(PrivacyPolicyRoute.name, path: '/privacy-policy-screen');

  static const String name = 'PrivacyPolicyRoute';
}

/// generated route for
/// [_i3.NotificationScreen]
class NotificationRoute extends _i5.PageRouteInfo<void> {
  const NotificationRoute()
      : super(NotificationRoute.name, path: '/notification-screen');

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i4.NotConnectedScreen]
class NotConnectedRoute extends _i5.PageRouteInfo<NotConnectedRouteArgs> {
  NotConnectedRoute({_i9.Key? key, required _i10.Future<dynamic> future})
      : super(NotConnectedRoute.name,
            path: '/not-connected-screen',
            args: NotConnectedRouteArgs(key: key, future: future));

  static const String name = 'NotConnectedRoute';
}

class NotConnectedRouteArgs {
  const NotConnectedRouteArgs({this.key, required this.future});

  final _i9.Key? key;

  final _i10.Future<dynamic> future;

  @override
  String toString() {
    return 'NotConnectedRouteArgs{key: $key, future: $future}';
  }
}

/// generated route for
/// [_i4.NoHistoryScreen]
class NoHistoryRoute extends _i5.PageRouteInfo<void> {
  const NoHistoryRoute()
      : super(NoHistoryRoute.name, path: '/no-history-screen');

  static const String name = 'NoHistoryRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class HomeRouter extends _i5.PageRouteInfo<void> {
  const HomeRouter({List<_i5.PageRouteInfo>? children})
      : super(HomeRouter.name, path: 'home', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class InsightRouter extends _i5.PageRouteInfo<void> {
  const InsightRouter({List<_i5.PageRouteInfo>? children})
      : super(InsightRouter.name, path: 'insight', initialChildren: children);

  static const String name = 'InsightRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class NotificationPostRouter extends _i5.PageRouteInfo<void> {
  const NotificationPostRouter({List<_i5.PageRouteInfo>? children})
      : super(NotificationPostRouter.name,
            path: 'notification', initialChildren: children);

  static const String name = 'NotificationPostRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ProfileRouter extends _i5.PageRouteInfo<void> {
  const ProfileRouter({List<_i5.PageRouteInfo>? children})
      : super(ProfileRouter.name, path: 'account', initialChildren: children);

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [_i6.HomePage]
class HomePage extends _i5.PageRouteInfo<void> {
  const HomePage() : super(HomePage.name, path: '');

  static const String name = 'HomePage';
}

/// generated route for
/// [_i6.InsightPage]
class InsightPage extends _i5.PageRouteInfo<void> {
  const InsightPage() : super(InsightPage.name, path: '');

  static const String name = 'InsightPage';
}

/// generated route for
/// [_i6.NotificationPage]
class NotificationPage extends _i5.PageRouteInfo<void> {
  const NotificationPage() : super(NotificationPage.name, path: '');

  static const String name = 'NotificationPage';
}

/// generated route for
/// [_i6.ProfilePage]
class ProfilePage extends _i5.PageRouteInfo<void> {
  const ProfilePage() : super(ProfilePage.name, path: '');

  static const String name = 'ProfilePage';
}
