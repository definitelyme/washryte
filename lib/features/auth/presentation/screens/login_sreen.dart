library login_sreen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:washryte/core/presentation/widgets/or_widget.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/auth/presentation/widgets/oauth_widgets.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

class LoginScreen extends StatefulWidget with AutoRouteWrapper {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

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

class _LoginScreenState extends State<LoginScreen> with AutomaticKeepAliveClientMixin<LoginScreen> {
  DateTime _timestampPressed = DateTime.now();

  @override
  bool get wantKeepAlive => true;

  Future<bool> maybePop() async {
    if (navigator.canNavigateBack) return true;

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
        overlayStyle: App.customSystemOverlay(ctx: context, android: Brightness.light, ios: Brightness.light),
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
                              'Login',
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: Utils.letterSpacing,
                            ),
                          ),
                          //
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.h),
                            child: Form(
                              key: AuthState.loginFormKey,
                              onChanged: () => Form.of(primaryFocus!.context!)?.save(),
                              child: const AutofillGroup(child: _FormLayout()),
                            ),
                          ),
                          //
                          VerticalSpace(height: 0.03.h),
                          //
                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen: (p, c) => p.isLoading != c.isLoading,
                            builder: (c, s) => Hero(
                              tag: Const.authButtonHeroTag,
                              child: AppButton(
                                text: 'Login',
                                isLoading: s.isLoading,
                                onPressed: () {
                                  TextInput.finishAutofillContext();
                                  c.read<AuthCubit>().login();
                                },
                              ),
                            ),
                          ),
                          //
                          VerticalSpace(height: 0.02.h),
                          //
                          if (!App.platform.isIOS) ...[
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
                          ],
                          //
                          VerticalSpace(height: 0.02.h),
                          //
                          Hero(
                            tag: Const.loginAndSignupSwitchTag,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: AdaptiveText.rich(
                                    TextSpan(children: [
                                      const TextSpan(text: 'Don\'t have an account? '),
                                      TextSpan(
                                        text: 'Sign Up',
                                        recognizer: TapGestureRecognizer()..onTap = () => navigator.navigate(const SignupRoute()),
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
                                    fontSize: 16.0,
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

class _FormLayout extends StatelessWidget {
  const _FormLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Material(
          color: Colors.transparent,
          child: Hero(
            tag: Const.emailLabelHeroTag,
            child: TextFormInputLabel(text: 'Email'),
          ),
        ),
        //
        EmailFormField<AuthCubit, AuthState>(
          useHero: true,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          field: (s) => s.user.email,
          focus: AuthState.emailFocus,
          next: AuthState.passwordFocus,
          response: (s) => s.status,
          onChanged: (fn, str) => fn.emailChanged(str),
        ),
        //
        VerticalSpace(height: 0.04.sw),
        //
        const Material(
          color: Colors.transparent,
          child: Hero(
            tag: Const.passwordLabelHeroTag,
            child: TextFormInputLabel(text: 'Password'),
          ),
        ),
        //
        PasswordFormField<AuthCubit, AuthState>(
          isNew: false,
          useHero: true,
          heroTag: Const.passwordFieldHeroTag,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          isObscured: (s) => s.isPasswordHidden,
          field: (s) => s.user.password,
          focus: AuthState.passwordFocus,
          response: (s) => s.status,
          errorField: (f) => f.errors?.password,
          onChanged: (fn, str) => fn.passwordChanged(str),
          onToggle: (it) => it.togglePasswordVisibility(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextFormInputLabel(
            text: 'Forgot Password?',
            textColor: Colors.black,
            fontWeight: FontWeight.w600,
            onPressed: () => navigator.push(const ForgotPasswordRoute()),
          ),
        ),
      ],
    );
  }
}
