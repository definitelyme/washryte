library password_reset_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render PasswordResetScreen.
class PasswordResetScreen extends StatefulWidget with AutoRouteWrapper {
  final Duration duration;
  final String email;

  const PasswordResetScreen({
    Key? key,
    required this.email,
    this.duration = const Duration(minutes: 2),
  }) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null && (c.status.getOrElse(() => null)!.response.maybeMap(orElse: () => false))),
        listener: (c, s) => s.status.fold(
          () => null,
          (it) => it?.response.map(
            info: (i) => PopupDialog.info(message: i.message, duration: const Duration(seconds: 4)).render(c),
            error: (f) => PopupDialog.error(message: f.message, show: f.show && f.message.isNotEmpty).render(c),
            success: (s) => PopupDialog.success(
              message: s.message,
              listener: (_) => _?.fold(
                dismissed: () => s.pop ? navigator.popUntil((route) => route.settings.name == LoginRoute.name) : null,
              ),
            ).render(c),
          ),
        ),
        child: this,
      ),
    );
  }

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  bool countDown = false;

  @override
  void initState() {
    countDown = widget.duration.inSeconds > 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSliverScrollView.scaffold(
      implyMiddle: false,
      title: 'Reset Password',
      subtitleWidget: AdaptiveText.rich(
        TextSpan(children: [
          const TextSpan(text: 'A Reset Token was sent to '),
          TextSpan(text: '${widget.email}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: ', kindly enter the code below to reset your password.'),
        ]),
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      ),
      scaffoldBackgroundColor: App.resolveColor(Palette.cardColorLight, dark: Palette.secondaryColor),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomInsetTab: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              0.02.verticalh,
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFormInputLabel(text: 'OTP'),
                  //
                  CountdownWidget(
                    autostart: countDown,
                    duration: widget.duration,
                    ticker: (tick) => AdaptiveText(
                      '$tick',
                      maxLines: 1,
                      fontSize: 16.sp,
                      maxFontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.end,
                    ),
                    child: (startCountDown) => BlocSelector<AuthCubit, AuthState, bool>(
                      selector: (s) => s.isLoading,
                      builder: (c, isLoading) => Disabled(
                        disabled: isLoading,
                        child: GestureDetector(
                          onTap: () async {
                            await context.read<AuthCubit>().forgotPassword(false);
                            startCountDown();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 5),
                            child: AdaptiveText.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: 'Resend',
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
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: Utils.labelLetterSpacing,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //
              ReactiveTextFormField<AuthCubit, AuthState>(
                hintText: (s) => 'Your Reset Token',
                disabled: (s) => s.isLoading,
                validate: (s) => s.validate,
                field: (s) => s.code,
                response: (s) => s.status,
                errorField: (f) => f.errors?.token,
                focus: AuthState.tokenFocus,
                next: AuthState.resetPasswordFocus,
                keyboardType: TextInputType.number,
                capitalization: TextCapitalization.none,
                onChanged: (cubit, it) => cubit.otpCodeChanged(it),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                  LengthLimitingTextInputFormatter(OTPCode.CODE_LENGTH),
                ],
              ),

              //
              0.02.verticalh,
              //
              const Align(
                alignment: Alignment.centerLeft,
                child: TextFormInputLabel(text: 'New Password'),
              ),
              //
              PasswordFormField<AuthCubit, AuthState>(
                isNew: true,
                useHero: false,
                disabled: (s) => s.isLoading,
                validate: (s) => s.validate,
                isObscured: (s) => s.isPasswordHidden,
                field: (s) => s.user.password,
                focus: AuthState.resetPasswordFocus,
                next: AuthState.passwordConfirmationFocus,
                response: (s) => s.status,
                errorField: (f) => f.errors?.password,
                onChanged: (fn, str) => fn.passwordChanged(str),
                onToggle: (it) => it.togglePasswordVisibility(),
              ),
              //
              0.02.verticalh,
              //
              const Align(
                alignment: Alignment.centerLeft,
                child: TextFormInputLabel(text: 'Confirm New Password'),
              ),
              //
              PasswordFormField<AuthCubit, AuthState>(
                isNew: true,
                useHero: false,
                disabled: (s) => s.isLoading,
                validate: (s) => s.validate,
                isObscured: (s) => s.isOldPasswordHidden,
                field: (s) => s.user.confirmation,
                focus: AuthState.passwordConfirmationFocus,
                response: (s) => s.status,
                onChanged: (fn, str) => fn.passwordConfirmationChanged(str),
                onToggle: (it) => it.toggleOldPasswordVisibility(),
              ),
            ]),
          ),
        ),
        //
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              0.04.verticalh,
              //
              BlocBuilder<AuthCubit, AuthState>(
                builder: (c, s) => AppButton(
                  text: 'Reset Password',
                  disabled:
                      s.isLoading || !s.user.confirmation.isValid || !s.user.password.isValid || !s.code.isValid || !s.passwordMatches,
                  isLoading: s.isLoading,
                  onPressed: c.read<AuthCubit>().resetPassword,
                ),
              ),
              //
              0.04.verticalh,
            ]),
          ),
        ),
      ],
    );
  }
}
