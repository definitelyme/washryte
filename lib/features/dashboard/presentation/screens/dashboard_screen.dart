library dashboard_screen.dart;

import 'dart:async';

import 'package:async/async.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/utils/utils.dart' hide HomePage, InsightPage, NotificationPage, ProfilePage;
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render DashboardScreen.
class DashboardScreen extends StatefulWidget with AutoRouteWrapper {
  static const _maxAvatarRadius = _minAvatarRadius + 3;
  static const _minAvatarRadius = 11.0;

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<TabNavigationCubit>(context),
      child: this,
    );
  }
}

class _DashboardScreenState extends State<DashboardScreen> with AutomaticKeepAliveClientMixin<DashboardScreen> {
  final AsyncMemoizer<dynamic> _memoizer = AsyncMemoizer();
  late TabNavigationCubit _navCubit;
  DateTime _timestampPressed = DateTime.now();

  @override
  void initState() {
    _navCubit = context.read<TabNavigationCubit>();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Widget defaultImage(int currentIndex, Destination i) => CircleAvatar(
        backgroundImage: Image.asset(AppAssets.unnamed).image,
        maxRadius: currentIndex == i.id ? DashboardScreen._maxAvatarRadius : DashboardScreen._minAvatarRadius + 1,
        minRadius: DashboardScreen._minAvatarRadius,
        backgroundColor: Colors.transparent,
      );

  Widget guestUserImage(int currentIndex, Destination i) => CircleAvatar(
        backgroundImage: Image.asset(AppAssets.guestAvatarPng).image,
        maxRadius: currentIndex == i.id ? DashboardScreen._maxAvatarRadius : DashboardScreen._minAvatarRadius + 1,
        minRadius: DashboardScreen._minAvatarRadius,
        backgroundColor: Colors.transparent,
      );

  Future<bool> maybePop() async {
    final now = DateTime.now();
    final difference = now.difference(_timestampPressed);
    final _showWarn = difference >= Utils.willPopTimeout;

    _timestampPressed = DateTime.now();

    if (_showWarn) {
      await ToastManager.short('Tap again to exit');
      return Future.value(false);
    } else {
      await ToastManager.cancel();
      return Future.value(true);
    }
  }

  double get minRadius => Utils.platform_(cupertino: 20, material: 20)!;
  double get maxRadius => Utils.platform_(cupertino: 23, material: 23)!;

  List<BottomNavigationBarItem> navItems(int currentIndex) {
    return Destination.list
        .map(
          (i) => BottomNavigationBarItem(
            label: i.title,
            icon: i == Destination.list.last
                ? BlocBuilder<AuthWatcherCubit, AuthWatcherState>(
                    buildWhen: (p, c) => p.user?.photo != c.user?.photo,
                    builder: (c, _s) {
                      if (_s.user == null) return guestUserImage(currentIndex, i);

                      return _s.user!.photo.ensure(
                        (it) => CachedNetworkImage(
                          imageUrl: '${it.getOrEmpty}',
                          fit: BoxFit.contain,
                          height: minRadius,
                          imageBuilder: (c, img) => CircleAvatar(
                            backgroundImage: img,
                            maxRadius: currentIndex == i.id ? DashboardScreen._maxAvatarRadius : DashboardScreen._minAvatarRadius + 1,
                            minRadius: DashboardScreen._minAvatarRadius,
                            backgroundColor: Colors.transparent,
                          ),
                          progressIndicatorBuilder: (_, url, download) => Center(
                            child: CircularProgressBar.adaptive(
                              value: download.progress,
                              strokeWidth: 1.5,
                              width: maxRadius + 2,
                              height: maxRadius + 2,
                            ),
                          ),
                          errorWidget: (_, url, error) => defaultImage(currentIndex, i),
                        ),
                        orElse: (_) => defaultImage(currentIndex, i),
                      );
                    },
                  )
                : SvgPicture.asset(
                    i.asset,
                    height: currentIndex == i.id ? maxRadius : minRadius,
                    width: currentIndex == i.id ? maxRadius : minRadius,
                    fit: BoxFit.contain,
                    color: currentIndex == i.id
                        ? Utils.foldTheme(light: () => Palette.accentColor, dark: () => Palette.accentColor.shade100)
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
            if (_navCubit.state.isInit) {
              _navCubit.updateTabsRouter(context.tabsRouter);
              _navCubit.init(context);
            }
          });

          return BlocBuilder<TabNavigationCubit, TabNavigationState>(
            buildWhen: (p, c) => p.currentIndex != c.currentIndex || p.isInit != c.isInit,
            builder: (c, s) {
              final currentIndex = s.currentIndex;

              return s.isInit
                  ? Center(child: App.circularLoadingOverlay)
                  : FutureBuilder(
                      future: _memoizer.runOnce(
                        () async {
                          final authWatcherCubit = BlocProvider.of<AuthWatcherCubit>(App.context);

                          unawaited(authWatcherCubit.subscribeUserChanges());
                        },
                      ),
                      builder: (_, snapshot) => AdaptiveScaffold(
                        cupertinoTabBuilder: (_, i) => s.tabs.toList()[i].values.first,
                        body: FadeTransition(opacity: animation, child: child),
                        adaptiveBottomNav: PlatformNavBar(
                          items: navItems(currentIndex),
                          currentIndex: currentIndex,
                          material: (_, __) => MaterialNavBarData(
                            elevation: 5.0,
                            type: BottomNavigationBarType.fixed,
                            unselectedItemColor: Colors.grey,
                            selectedItemColor: App.resolveColor(Palette.accentColor, dark: Palette.accentColor.shade100),
                          ),
                          cupertino: (_, __) => CupertinoTabBarData(
                            iconSize: maxRadius,
                            border: const Border(top: BorderSide(color: Colors.grey, width: 1)),
                            inactiveColor: Colors.grey,
                            backgroundColor: App.resolveColor(
                              CupertinoColors.lightBackgroundGray.withAlpha(254),
                              dark: CupertinoColors.quaternarySystemFill,
                            )!,
                            currentIndex: currentIndex,
                            activeColor: App.resolveColor(Palette.accentColor, dark: Palette.accentColor.shade100),
                          ),
                          itemChanged: (i) => c.read<TabNavigationCubit>().setCurrentIndex(context, i),
                        ),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
