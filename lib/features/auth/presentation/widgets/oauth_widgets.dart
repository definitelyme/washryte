import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

class OAuthWidgets extends StatelessWidget {
  final bool email;
  final bool google;
  final bool apple;

  final AuthCubit cubit;

  const OAuthWidgets({
    Key? key,
    required this.cubit,
    this.email = false,
    this.google = true,
    this.apple = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Builder(
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...[
              Flexible(
                child: BlocSelector<AuthWatcherCubit, AuthWatcherState, bool>(
                  selector: (s) => s.isLoggingOut,
                  builder: (c, isLoading) => SocialBuilder(
                    isLoading: !isLoading,
                    visiblility: email,
                    text: 'Continue with Email',
                    textColor: Palette.text100,
                    textColorDark: Palette.text100Dark,
                    icon: AppAssets.emailRegular(App.resolveColor(
                      Palette.accentColor,
                    )),
                    onPressed: () async {
                      await BlocProvider.of<AuthWatcherCubit>(context).signOut();
                      unawaited(navigator.push(const GetStartedRoute()));
                    },
                  ),
                ),
              ),
            ],
            ...[
              if (!google && email) HorizontalSpace(width: 0.07.sw),
              //
              Flexible(
                child: BlocSelector<AuthCubit, AuthState, bool>(
                  selector: (s) => s.isGoogleAuthLoading,
                  builder: (c, isLoading) => SocialBuilder(
                    isLoading: !isLoading,
                    visiblility: google,
                    text: 'Continue with Google',
                    textColor: Palette.text100,
                    textColorDark: Palette.text100Dark,
                    icon: AppAssets.google,
                    onPressed: BlocProvider.of<AuthCubit>(context).googleAuth,
                  ),
                ),
              ),
            ],
            //
            // if (Platform.isIOS || Platform.isMacOS) ...[
            if (Platform.isMacOS) ...[
              if (apple) VerticalSpace(height: 0.005.h),
              //
              Flexible(
                child: BlocSelector<AuthCubit, AuthState, bool>(
                  selector: (s) => s.isAppleAuthLoading,
                  builder: (c, isLoading) => AnimatedVisibility(
                    visible: apple,
                    child: AnimatedVisibility(
                      visible: !isLoading,
                      replacement: App.loadingSpinningLines,
                      child: SignInWithAppleButton(
                        onPressed: context.read<AuthCubit>().appleAuth,
                        borderRadius: Utils.buttonRadius.br,
                        style: SignInWithAppleButtonStyle.whiteOutlined,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class SocialBuilder extends StatelessWidget {
  final bool visiblility;
  final bool isLoading;
  final Color? textColor;
  final Color? textColorDark;
  final Color? bgColor;
  final Widget icon;
  final String text;
  final VoidCallback? onPressed;
  final Color? splashLight;
  final Color? splashDark;

  const SocialBuilder({
    Key? key,
    required this.visiblility,
    this.isLoading = false,
    this.textColor,
    this.textColorDark,
    this.bgColor,
    required this.icon,
    required this.text,
    this.onPressed,
    this.splashLight,
    this.splashDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedVisibility(
      visible: visiblility,
      child: AnimatedVisibility(
        visible: isLoading,
        replacement: App.loadingSpinningLines,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AdaptiveButton(
                leading: icon,
                text: text,
                borderRadius: BorderRadius.circular(Utils.buttonRadius),
                textColor: textColor ?? Palette.neutralF4,
                textColorDark: textColorDark ?? Colors.white70,
                backgroundColor: App.resolveColor(bgColor ?? Palette.neutralFA),
                childPadding: EdgeInsets.symmetric(horizontal: 0.04.sw),
                side: const BorderSide(color: Palette.neutralF4),
                splashColor: App.resolveColor(
                  splashLight ?? Colors.grey.shade300,
                  dark: splashDark ?? Colors.grey.shade800,
                ),
                onPressed: onPressed,
              ),
            ),
            //
            VerticalSpace(height: 0.005.h),
          ],
        ),
      ),
    );
  }
}
