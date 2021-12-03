import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        builder: (context) => Material(
          type: MaterialType.transparency,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: BlocSelector<AuthWatcherCubit, AuthWatcherState, bool>(
                  selector: (s) => s.isLoggingOut,
                  builder: (c, isLoading) => SocialBuilder(
                    isLoading: !isLoading,
                    visiblility: email,
                    text: 'Continue with Email',
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
              //
              ...[
                if (google) HorizontalSpace(width: 0.07.sw),
                //
                Flexible(
                  child: BlocSelector<AuthCubit, AuthState, bool>(
                    selector: (s) => s.isGoogleAuthLoading,
                    builder: (c, isLoading) => SocialBuilder(
                      isLoading: !isLoading,
                      visiblility: google,
                      text: 'Continue with Google',
                      // color: App.resolveColor(
                      //   Palette.oAuthColor,
                      //   dark: Colors.white,
                      // ),
                      icon: AppAssets.google(),
                      onPressed: BlocProvider.of<AuthCubit>(context).googleAuth,
                    ),
                  ),
                ),
              ],
              //
              if (Platform.isIOS || Platform.isMacOS) ...[
                if (apple) HorizontalSpace(width: 0.07.sw),
                //
                Flexible(
                  child: BlocSelector<AuthCubit, AuthState, bool>(
                    selector: (s) => s.isAppleAuthLoading,
                    builder: (c, isLoading) => SocialBuilder(
                      isLoading: !isLoading,
                      visiblility: apple,
                      text: 'Continue with Apple',
                      // color: App.resolveColor(
                      //   null,
                      //   dark: Palette.secondaryColor.shade400,
                      // ),
                      icon: AppAssets.apple(
                        App.resolveColor(null,
                            dark: Utils.computeLuminance(
                              Theme.of(context).scaffoldBackgroundColor,
                            )),
                      ),
                      onPressed: BlocProvider.of<AuthCubit>(context).appleAuth,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class SocialBuilder extends StatelessWidget {
  final bool visiblility;
  final bool isLoading;
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Utils.buttonRadius),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Material(
              elevation: 1.0,
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(Utils.buttonRadius),
              child: InkWell(
                onTap: onPressed,
                splashColor: App.resolveColor(
                  splashLight ?? Colors.grey.shade300,
                  dark: splashDark ?? Colors.grey.shade800,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
