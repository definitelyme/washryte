library signup_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/auth/presentation/widgets/oauth_widgets.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

part '../widgets/_signup_forms.dart';

class SignupScreen extends StatefulWidget with AutoRouteWrapper {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
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
        child: this,
      ),
    );
  }
}

class _SignupScreenState extends State<SignupScreen> with AutomaticKeepAliveClientMixin<SignupScreen> {
  DateTime _timestampPressed = DateTime.now();

  final TapGestureRecognizer tapRecognizer = TapGestureRecognizer()..onTap = (() => navigator.navigate(const LoginRoute()));

  @override
  bool get wantKeepAlive => true;

  Future<bool> maybePop() async {
    if (!navigator.isRoot) return true;

    final now = DateTime.now();
    final difference = now.difference(_timestampPressed);
    final _showWarn = difference >= Utils.willPopTimeout;

    _timestampPressed = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: maybePop,
      child: AdaptiveScaffold(
        body: Stack(
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
            Positioned.fill(
              child: Center(
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  controller: ScrollController(),
                  physics: Utils.physics,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 0.06.w),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Utils.buttonRadius),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.03.h),
                      child: Column(
                        children: [
                          Center(
                            child: AdaptiveText(
                              'Create Account',
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: Utils.letterSpacing,
                            ),
                          ),
                          //
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.h),
                            child: Form(
                              key: AuthState.signupFormKey,
                              onChanged: () => Form.of(primaryFocus!.context!)?.save(),
                              child: const AutofillGroup(child: _FormLayout()),
                            ),
                          ),
                          //
                          VerticalSpace(height: 0.02.h),
                          //
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (c, s) => Hero(
                              tag: Const.authButtonHeroTag,
                              child: AppButton(
                                text: 'Create Account',
                                isLoading: s.isLoading,
                                onPressed: () {
                                  TextInput.finishAutofillContext();
                                  c.read<AuthCubit>().createAccount();
                                },
                              ),
                            ),
                          ),
                          //
                          VerticalSpace(height: 0.02.h),
                          //
                          const OrWidget(),
                          //
                          VerticalSpace(height: 0.02.h),
                          //
                          MyHero(
                            tag: Const.oauthBtnHeroTag,
                            type: MaterialType.transparency,
                            child: Center(child: OAuthWidgets(cubit: context.read<AuthCubit>())),
                          ),
                          //
                          VerticalSpace(height: 0.02.h),
                          //
                          Hero(
                            tag: Const.loginAndSignupSwitchTag,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: AdaptiveText.rich(
                                    TextSpan(children: [
                                      const TextSpan(text: 'Already have an account? '),
                                      TextSpan(
                                        text: 'Log In',
                                        recognizer: tapRecognizer,
                                        style: TextStyle(
                                          color: Utils.foldTheme(
                                            context: context,
                                            light: () => Palette.accentColor,
                                            dark: () => Palette.accentColor.shade100,
                                          ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: Utils.labelLetterSpacing,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //
                          VerticalSpace(height: 0.1.sw),
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
    );
  }
}
