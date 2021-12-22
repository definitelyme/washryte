library profile_page.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/dashboard/presentation/widgets/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

part '../widgets/password_update_bottom_sheet.dart';
part '../widgets/edit_profile_bottom_sheet.dart';

/// A stateless widget to render ProfilePage.
class ProfilePage extends StatelessWidget with AutoRouteWrapper {
  static final boxHeight = 0.13.h;
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: CustomScrollView(
        physics: Utils.physics,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: App.sidePadding),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => navigator.push(const ProfileViewRoute()),
                  child: Row(
                    children: [
                      ImageBox.asset(
                        photo: AppAssets.blackAvatar,
                        width: 0.13.w,
                        height: 0.13.w,
                        elevation: 3,
                        borderRadius: BorderRadius.circular(100),
                        fit: BoxFit.cover,
                        applyConstraintToReplacement: true,
                        replacement: Image.asset(AppAssets.blackAvatar),
                      ),
                      //
                      0.04.horizontalw,
                      //
                      BlocSelector<AuthWatcherCubit, AuthWatcherState, User?>(
                        selector: (s) => s.user,
                        builder: (c, user) => Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AdaptiveText(
                              'Hello,',
                              fontSize: 17.sp,
                              maxLines: 1,
                              fontWeight: FontWeight.w400,
                              letterSpacing: Utils.letterSpacing,
                            ),
                            AdaptiveText(
                              '${user?.fullName.getOrEmpty}',
                              fontSize: 18.sp,
                              maxLines: 1,
                              fontWeight: FontWeight.w600,
                              letterSpacing: Utils.letterSpacing,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                0.025.verticalh,
                //
                SizedBox(
                  height: ProfilePage.boxHeight,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 0.78.w,
                            height: double.infinity,
                            child: Material(
                              color: const Color(0xff1fbfff),
                              elevation: 10,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      //
                      Positioned.fill(
                        bottom: ProfilePage.boxHeight * 0.07,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 0.86.w,
                            height: double.infinity,
                            child: Material(
                              color: const Color(0xff00aff5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      //
                      Positioned.fill(
                        bottom: ProfilePage.boxHeight * 0.15,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 0.93.w,
                            height: double.infinity,
                            child: Material(
                              color: const Color(0xff0088c0),
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: App.sidePadding, vertical: App.sidePadding * 0.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: AdaptiveText(
                                        'Available Balance',
                                        fontSize: 16.sp,
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    //
                                    Flexible(
                                      child: Row(
                                        children: [
                                          AdaptiveText(
                                            'N 300,000.00',
                                            fontSize: 20.sp,
                                            textColor: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          //
                                          0.03.horizontalw,
                                          //
                                          Material(
                                            type: MaterialType.transparency,
                                            shape: const CircleBorder(),
                                            clipBehavior: Clip.hardEdge,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                AppIcons.eyelash_open,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          //
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              0.03.verticalh,
              //
              Center(
                child: AdaptiveText(
                  'Manage Account',
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: Utils.letterSpacing,
                ),
              ),
              //
              0.02.verticalh,
              //
              ..._ProfileTile.list(context).map(
                (e) => AdaptiveListTile(
                  material: true,
                  title: AdaptiveText(
                    '${e.title}',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  horizontalTitleGap: 6,
                  contentPadding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                  leading: Icon(e.asset, size: e.size),
                  trailing: AnimatedVisibility(
                    visible: e.hasTrailing,
                    child: Material(
                      borderRadius: 7.br,
                      color: const Color(0xffE7F1F5),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.chevron_right_rounded),
                      ),
                    ),
                  ),
                  onTap: e.onPressed,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile {
  final String title;
  final IconData asset;
  final VoidCallback? onPressed;
  final double size;
  final bool hasTrailing;

  const _ProfileTile({
    required this.title,
    required this.asset,
    this.onPressed,
    this.size = 24,
    this.hasTrailing = true,
  });

  static List<_ProfileTile> list(BuildContext ctx) => [
        _ProfileTile(
          title: 'Edit Profile',
          asset: WashryteIcon.profile_user,
          onPressed: () => App.showAdaptiveBottomSheet(
            ctx,
            elevation: 2.0,
            isDismissible: false,
            bounce: true,
            useRootNavigator: true,
            builder: (_) => const _EditProfileBottomSheet(),
          ),
        ),
        _ProfileTile(
          title: 'Top-up Wallet',
          asset: WashryteIcon.profile_wallet,
          onPressed: () {},
        ),
        _ProfileTile(
          title: 'Order History',
          size: 20,
          asset: WashryteIcon.profile_history,
          onPressed: () => navigator.push(const OrderHistoryRoute()),
        ),
        _ProfileTile(
          title: 'Security',
          size: 20,
          asset: WashryteIcon.profile_security,
          onPressed: () => App.showAdaptiveBottomSheet(
            ctx,
            bounce: true,
            enableDrag: true,
            useRootNavigator: true,
            builder: (_) => const _PasswordUpdateBottomSheet(),
          ),
        ),
        _ProfileTile(
          title: 'Logout',
          asset: WashryteIcon.profile_logout,
          hasTrailing: false,
          onPressed: () {},
        ),
      ];
}
