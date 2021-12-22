library dashboard_screen.dart;

import 'dart:async';

import 'package:async/async.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/manager/settings/index.dart';
import 'package:washryte/utils/utils.dart' hide HomePage, InsightPage, NotificationPage, ProfilePage;
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render DashboardScreen.
class DashboardScreen extends StatefulWidget with AutoRouteWrapper {
  static const _maxAvatarRadius = _minAvatarRadius + 4;
  static const _minAvatarRadius = 11.0;

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<GlobalAppPreferenceCubit>().updateLaunchSettings();
    return BlocProvider.value(
      value: BlocProvider.of<TabNavigationCubit>(context),
      child: this,
    );
  }
}

class _DashboardScreenState extends State<DashboardScreen> with AutomaticKeepAliveClientMixin<DashboardScreen> {
  final AsyncMemoizer<bool> _memoizer = AsyncMemoizer();
  DateTime _timestampPressed = DateTime.now();

  @override
  bool get wantKeepAlive => true;

  Widget defaultImage(TabNavigationState s, Destination i) => CircleAvatar(
        backgroundImage: Image.asset(AppAssets.unnamed).image,
        maxRadius: s.currentIndex == i.id ? DashboardScreen._maxAvatarRadius : DashboardScreen._minAvatarRadius + 2,
        minRadius: DashboardScreen._minAvatarRadius,
        backgroundColor: Colors.transparent,
      );

  Widget guestUserImage(TabNavigationState s, Destination i) => CircleAvatar(
        backgroundImage: Image.asset(AppAssets.guestAvatarPng).image,
        maxRadius: s.currentIndex == i.id ? DashboardScreen._maxAvatarRadius : DashboardScreen._minAvatarRadius + 2,
        minRadius: DashboardScreen._minAvatarRadius,
        backgroundColor: Colors.transparent,
      );

  Future<bool> maybePop() async {
    final now = DateTime.now();
    final difference = now.difference(_timestampPressed);
    final _showWarn = difference >= Utils.willPopTimeout;

    setState(() => _timestampPressed = DateTime.now());

    if (_showWarn) {
      await Fluttertoast.showToast(
        msg: 'Tap again to exit',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return Future.value(false);
    } else {
      await Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  List<BottomNavigationBarItem> navItems(TabNavigationState s) {
    return Destination.list
        .map(
          (i) => BottomNavigationBarItem(
            label: i.title,
            icon: i == Destination.list.last
                ? BlocBuilder<AuthWatcherCubit, AuthWatcherState>(
                    buildWhen: (p, c) => p.user?.photo != c.user?.photo,
                    builder: (c, _s) {
                      if (_s.user == null) return guestUserImage(s, i);

                      return _s.user!.photo.ensure(
                        (it) => CachedNetworkImage(
                          imageUrl: '${it.getOrEmpty}',
                          fit: BoxFit.contain,
                          height: 20,
                          imageBuilder: (c, img) => CircleAvatar(
                            backgroundImage: img,
                            maxRadius: s.currentIndex == i.id ? DashboardScreen._maxAvatarRadius : DashboardScreen._minAvatarRadius + 2,
                            minRadius: DashboardScreen._minAvatarRadius,
                            backgroundColor: Colors.transparent,
                          ),
                          progressIndicatorBuilder: (_, url, download) => Center(
                            child: CircularProgressBar.adaptive(
                              value: download.progress,
                              strokeWidth: 1.5,
                              width: 25,
                              height: 25,
                            ),
                          ),
                          errorWidget: (_, url, error) => defaultImage(s, i),
                        ),
                        orElse: (_) => defaultImage(s, i),
                      );
                    },
                  )
                : SvgPicture.asset(
                    i.asset,
                    height: s.currentIndex == i.id ? 23 : 20,
                    width: s.currentIndex == i.id ? 23 : 20,
                    fit: BoxFit.contain,
                    color: s.currentIndex == i.id
                        ? Utils.foldTheme(
                            light: () => Palette.accentColor,
                            dark: () => Palette.accentColor.shade100,
                          )
                        : Colors.grey,
                  ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: maybePop,
      child: AutoTabsRouter(
        routes: [
          const HomeRouter(),
          const InsightRouter(),
          const NotificationPostRouter(),
          const ProfileRouter(),
        ],
        inheritNavigatorObservers: true,
        navigatorObservers: () => <NavigatorObserver>[AutoRouteObserver()],
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        builder: (context, child, animation) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if (context.read<TabNavigationCubit>().state.isInit) {
              context.read<TabNavigationCubit>().updateTabsRouter(context.tabsRouter);
              context.read<TabNavigationCubit>().init();
            }
          });

          return BlocBuilder<TabNavigationCubit, TabNavigationState>(
            builder: (c, s) => FutureBuilder(
              future: _memoizer.runOnce(
                () async {
                  unawaited(BlocProvider.of<AuthWatcherCubit>(App.context).subscribeUserChanges());

                  return false;
                },
              ),
              builder: (_, snapshot) => AdaptiveScaffold(
                cupertinoTabBuilder: (_, i) => s.tabs.toList()[i].values.first,
                body: FadeTransition(opacity: animation, child: child),
                adaptiveBottomNav: PlatformNavBar(
                  items: navItems(s),
                  currentIndex: s.currentIndex,
                  material: (_, __) => MaterialNavBarData(
                    elevation: 0.0,
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Utils.foldTheme(
                      light: () => Palette.accentColor,
                      dark: () => Palette.accentColor.shade100,
                    ),
                  ),
                  cupertino: (_, __) => CupertinoTabBarData(
                    iconSize: 20,
                    inactiveColor: Colors.grey,
                    currentIndex: s.currentIndex,
                    activeColor: Utils.foldTheme(
                      light: () => Palette.accentColor,
                      dark: () => Palette.accentColor.shade100,
                    ),
                  ),
                  itemChanged: (i) => c.read<TabNavigationCubit>().setCurrentIndex(context.tabsRouter, i),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
