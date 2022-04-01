library profile_page.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
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

  String balance(double? balance, bool isHidden) {
    if (balance == null || balance == 0 || balance == 0.0) return '0';
    // final shade = '*' * balance.toString().length;
    return isHidden ? '*******' : '$balance'.asCurrency();
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
            left: false,
            right: false,
            bottom: false,
            sliver: SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: App.sidePadding),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  // onTap: () => navigator.push(const ProfileViewRoute()),
                  child: const GreetingWidget(),
                ),
              ),
            ),
          ),
          //
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                0.02.verticalh,
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
                                child: BlocBuilder<AuthWatcherCubit, AuthWatcherState>(
                                  builder: (c, s) => Column(
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
                                              balance(s.user?.balance.getOrNull, c.read<AuthWatcherCubit>().isBalanceHidden),
                                              fontSize: 20.sp,
                                              textColor: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            //
                                            0.03.horizontalw,
                                            //
                                            AnimatedVisibility(
                                              visible: s.user?.balance.getOrNull != 0,
                                              child: Material(
                                                type: MaterialType.transparency,
                                                shape: const CircleBorder(),
                                                clipBehavior: Clip.hardEdge,
                                                child: IconButton(
                                                  onPressed: c.read<AuthWatcherCubit>().toggleBalance,
                                                  icon: Icon(
                                                    c.read<AuthWatcherCubit>().isBalanceHidden
                                                        ? AppIcons.eyelash_closed
                                                        : AppIcons.eyelash_open,
                                                    color: Colors.white,
                                                  ),
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
                    replacement: e.trailing ?? Utils.nothing,
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
  final Widget? trailing;

  const _ProfileTile({
    required this.title,
    required this.asset,
    this.onPressed,
    this.size = 24,
    this.hasTrailing = true,
    this.trailing,
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
          onPressed: () => App.showAlertDialog(
            context: ctx,
            useSafeArea: true,
            builder: (_) => ReactiveAdaptiveAlertdialog<RequestCubit, RequestState>(
              bloc: getIt<RequestCubit>(),
              listeners: [
                BlocListener<RequestCubit, RequestState>(listener: (c, s) {
                  if (s.request.id.value != null && s.canPay && !s.isLoading) {
                    WidgetsBinding.instance!.endOfFrame.then((_) {
                      final user = ctx.read<AuthWatcherCubit>().state.user;
                      c.read<RequestCubit>().deposit(c, user, callback: navigator.pop);
                    });
                  }
                }),
                BlocListener<RequestCubit, RequestState>(
                  listenWhen: (p, c) =>
                      p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
                      (c.status.getOrElse(() => null) != null && (c.status.getOrElse(() => null)!.response.maybeMap(orElse: () => false))),
                  listener: (c, s) => s.status.fold(
                    () => null,
                    (it) => it?.response.map(
                      info: (i) => PopupDialog.info(message: i.message, show: i.message.isNotEmpty).render(c),
                      error: (f) => PopupDialog.error(message: f.message, show: f.show && f.message.isNotEmpty).render(c),
                      success: (s) => PopupDialog.success(message: s.message, show: s.message.isNotEmpty).render(c),
                    ),
                  ),
                ),
              ],
              dialog: (c, s) => AdaptiveAlertdialog(
                title: 'Fund Wallet',
                titleHeight: 0.035.h,
                contentAlignment: Alignment.centerLeft,
                body: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextFormInputLabel(
                      text: 'Amount',
                      useDefaultText: Utils.platform_(cupertino: true),
                    ),
                  ),
                  //
                  ReactiveTextFormField<RequestCubit, RequestState>(
                    // state: s,
                    hintText: (s) => 'Enter Amount',
                    controller: (s) => s.amountTextController,
                    disabled: (s) => s.isLoading,
                    validate: (s) => s.validate,
                    response: (s) => s.status,
                    field: (s) => s.request.amount,
                    errorField: (s) => s.errors?.amount,
                    autoDisposeController: false,
                    keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                    capitalization: TextCapitalization.none,
                    onChanged: (cubit, __) => cubit.amountChanged(),
                  ),
                  //
                  0.01.verticalh,
                  //
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AdaptiveText.rich(
                      TextSpan(children: [
                        const TextSpan(text: 'Minimum Top-up Amount is '),
                        TextSpan(text: '${RequestCubit.MINIMUM_FUND_AMOUNT}'.asCurrency()),
                      ]),
                      isDefault: Utils.platform_(cupertino: true),
                      textColor: Colors.grey,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                secondButtonIsLoading: s.isLoading,
                secondButtonDisabled: s.request.amount.getOrNull < RequestCubit.MINIMUM_FUND_AMOUNT,
                secondBgColor: Palette.accentColor,
                secondTextStyle: const TextStyle(color: Colors.white),
                secondSplashColor: Colors.black12,
                autoPopSecondButton: false,
                secondButtonText: 'Fund',
                onSecondPressed: c.read<RequestCubit>().fundWallet,
              ),
            ),
          ),
        ),
        _ProfileTile(
          title: 'Order History',
          size: 20,
          asset: WashryteIcon.profile_history,
          onPressed: () => navigator.push(const OrderHistoryRoute()),
        ),
        _ProfileTile(
          title: 'Change Password',
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
          trailing: BlocSelector<AuthWatcherCubit, AuthWatcherState, bool>(
            selector: (s) => s.isLoggingOut,
            builder: (c, isLoading) => AnimatedVisibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(3),
                child: CircularProgressBar.adaptive(strokeWidth: 2, width: 25, height: 25),
              ),
            ),
          ),
          onPressed: () async {
            // Signout the authenticated rider
            await ctx.read<AuthWatcherCubit>().signOut();
            // Reset current Index to 0
            ctx.read<TabNavigationCubit>().reset();
          },
        ),
      ];
}
