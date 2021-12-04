library get_started_screen.dart;

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/auth/presentation/widgets/oauth_widgets.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render GetStartedScreen.
class GetStartedScreen extends StatelessWidget with AutoRouteWrapper {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null &&
                (c.status.getOrElse(() => null)!.response.maybeMap(
                      error: (f) => f.fold(
                        is41101: () {
                          WidgetsBinding.instance?.addPostFrameCallback((_) => navigateToSocials());
                          return false;
                        },
                        orElse: () => false,
                      ),
                      orElse: () => false,
                    ))),
        listener: (c, s) => s.status.fold(
          () => null,
          (th) => th?.response.map(
            error: (f) => PopupDialog.error(message: f.message).render(c),
            success: (s) => PopupDialog.success(message: s.message).render(c),
          ),
        ),
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: AdaptiveScaffoldBody(
        body: CustomScrollView(
          shrinkWrap: true,
          physics: Utils.physics,
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 1.h,
                width: 1.w,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: Image.asset(
                          AppAssets.onboarding,
                          width: 1.w,
                          height: 1.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    //
                    const Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.8),
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black12,
                              Colors.black26,
                              Colors.black38,
                              Colors.black54,
                              Colors.black87,
                              Colors.black87,
                              Colors.black87,
                            ],
                          ),
                        ),
                      ),
                    ),
                    //
                    Positioned(
                      top: 0.5.h,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SafeArea(
                        top: false,
                        left: true,
                        right: true,
                        bottom: true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: App.sidePadding,
                          ).copyWith(top: 0.03.h),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: AdaptiveText(
                                    'Welcome to WashRyte Laundry',
                                    maxLines: 1,
                                    minFontSize: 13,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w800,
                                    textColor: Colors.white,
                                    softWrap: false,
                                    wrapWords: false,
                                  ),
                                ),
                                //
                                VerticalSpace(height: 0.01.sw),
                                //
                                Flexible(
                                  flex: 5,
                                  child: AdaptiveText(
                                    'Have your clothes picked up for dry cleaning and delivered to you after wash.',
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    minFontSize: 13,
                                    fontSize: 18.sp,
                                    textColor: Colors.white,
                                    wordSpacing: 2.0,
                                    softWrap: true,
                                    wrapWords: true,
                                  ),
                                ),
                                //
                                VerticalSpace(height: 0.02.sw),
                                //
                                Expanded(
                                  flex: 15,
                                  child: Column(
                                    mainAxisAlignment:
                                        Platform.isIOS || Platform.isMacOS ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: AppButton(
                                          text: 'Create Account',
                                          fontWeight: FontWeight.w600,
                                          onPressed: () => navigator.pushAndPopUntil(
                                            const SignupRoute(),
                                            predicate: (_) => false,
                                          ),
                                        ),
                                      ),
                                      //
                                      VerticalSpace(height: 0.01.h),
                                      //
                                      Flexible(
                                        flex: 2,
                                        child: AppOutlinedButton(
                                          text: 'Login',
                                          fontWeight: FontWeight.w600,
                                          textColor: Palette.accentColor,
                                          splashColor: Colors.white24,
                                          onPressed: () => navigator.pushAndPopUntil(
                                            const LoginRoute(),
                                            predicate: (_) => false,
                                          ),
                                        ),
                                      ),
                                      //
                                      VerticalSpace(height: 0.005.h),
                                      //
                                      Expanded(
                                        flex: 5,
                                        child: MyHero(
                                          tag: Const.oauthBtnHeroTag,
                                          type: MaterialType.transparency,
                                          child: OAuthWidgets(cubit: context.read<AuthCubit>()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //
                                VerticalSpace(height: 0.03.sw),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
