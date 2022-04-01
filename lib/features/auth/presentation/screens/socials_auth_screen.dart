library socials_auth_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/auth/presentation/widgets/oauth_widgets.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render SocialsAuthScreen.
class SocialsAuthScreen extends StatefulWidget with AutoRouteWrapper {
  const SocialsAuthScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>()..initSocials(),
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null && (c.status.getOrElse(() => null)!.fold(orElse: () => false))),
        listener: (c, s) => s.status.fold(
          () => null,
          (th) => th?.response.map(
            info: (i) => PopupDialog.error(message: i.message, show: i.message.isNotEmpty).render(c),
            error: (f) => PopupDialog.error(message: f.message, show: f.show && f.message.isNotEmpty).render(c),
            success: (s) => PopupDialog.success(message: s.message, show: s.message.isNotEmpty).render(c),
          ),
        ),
        child: this,
      ),
    );
  }

  @override
  State<SocialsAuthScreen> createState() => _SocialsAuthScreenState();
}

class _SocialsAuthScreenState extends State<SocialsAuthScreen> {
  DateTime _timestampPressed = DateTime.now();
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final usernameFocus = FocusNode();
  final phoneFocus = FocusNode();

  Future<bool> maybePop() async {
    if (context.watchRouter.canPopSelfOrChildren) return Future.value(true);

    final now = DateTime.now();
    final difference = now.difference(_timestampPressed);
    final _showWarn = difference >= Utils.willPopTimeout;

    setState(() => _timestampPressed = DateTime.now());

    if (_showWarn) {
      await ToastManager.short('Tap again to exit');
      return Future.value(false);
    } else {
      await ToastManager.cancel();
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: maybePop,
      child: AdaptiveScaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          clipBehavior: Clip.antiAlias,
          controller: ScrollController(),
          physics: Utils.physics,
          scrollDirection: Axis.vertical,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.07.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  AdaptiveText.rich(
                    TextSpan(children: [
                      if (context.watch<AuthCubit>().state.user.provider != AuthProvider.apple)
                        const TextSpan(text: 'Continue with socials'),
                      if (context.watch<AuthCubit>().state.user.provider == AuthProvider.apple)
                        const TextSpan(text: 'Let’s update your profile 🙂'),
                    ]),
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: Utils.letterSpacing,
                  ),
                  //
                  0.014.verticalh,
                  //
                  BlocSelector<AuthCubit, AuthState, User>(
                    selector: (s) => s.user,
                    builder: (c, user) => AdaptiveText.rich(
                      TextSpan(children: [
                        if (context.watch<AuthCubit>().state.user.provider != AuthProvider.apple)
                          TextSpan(text: 'You are continuing with ${user.email.getOrNull ?? 'socials'}'),
                        if (context.watch<AuthCubit>().state.user.provider == AuthProvider.apple)
                          const TextSpan(text: 'Kindly enter a valid phone number to get the best out of ${Const.appName}.'),
                      ]),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: Utils.letterSpacing,
                    ),
                  ),
                  if (context.watch<AuthCubit>().state.user.provider != AuthProvider.apple) ...[
                    //
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocSelector<AuthCubit, AuthState, User>(
                            selector: (s) => s.user,
                            builder: (c, user) => GestureDetector(
                              onTap: () => user.provider.when(
                                regular: () => c.read<AuthWatcherCubit>().toggleLogoutLoading(true),
                                google: c.read<AuthCubit>().googleAuth,
                                apple: c.read<AuthCubit>().appleAuth,
                              ),
                              child: AdaptiveText(
                                'Change',
                                fontSize: 16.sp,
                                textColor: Palette.accentColor,
                                fontWeight: FontWeight.w400,
                                letterSpacing: Utils.letterSpacing,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          //
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (c, s) => AnimatedVisibility(
                              visible: (s.isLoading && !s.user.email.isValid) || s.isGoogleAuthLoading,
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: CircularProgressBar.adaptive(strokeWidth: 2.3, width: 21, height: 21),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    0.008.verticalh,
                  ],
                  //
                  AutofillGroup(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (context.watch<AuthCubit>().state.user.provider != AuthProvider.apple) ...[
                          const TextFormInputLabel(text: 'First Name'),
                          //
                          NameFormField<AuthCubit, AuthState>(
                            initial: (s) => s.user.fullName.getOrEmpty,
                            disabled: (s) => s.isLoading,
                            // validate: (s) => s.validate,
                            validate: (s) => false,
                            field: (s) => s.user.fullName,
                            focus: firstNameFocus,
                            next: lastNameFocus,
                            onChanged: (it, str) => it.nameChanged(str),
                          ),
                          //
                          0.018.verticalh,
                          //
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: TextFormInputLabel(text: 'Email Address'),
                          ),
                          //
                          Opacity(
                            opacity: 0.6,
                            child: EmailFormField<AuthCubit, AuthState>(
                              initial: (s) => s.user.email.getOrEmpty,
                              useHero: false,
                              disabled: (s) => true,
                              readOnly: (_) => true,
                            ),
                          ),
                        ],
                        //
                        0.018.verticalh,
                        //
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextFormInputLabel(text: 'Phone Number'),
                        ),
                        //
                        PhoneFormField<AuthCubit, AuthState>(
                          initial: (s) => s.user.phone.getOrEmpty,
                          disabled: (s) => s.isLoading,
                          validate: (s) => s.user.provider.maybeWhen(apple: () => false, orElse: () => s.validate),
                          field: (s) => s.user.phone,
                          focus: phoneFocus,
                          controller: (s) => s.phoneTextController,
                          response: (s) => s.status,
                          autoDisposeController: false,
                          onChanged: (cubit, str) => cubit.phoneNumberChanged(str),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            //
            SliverSafeArea(
              top: false,
              left: false,
              right: false,
              sliver: SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.06.h),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (c, s) => Hero(
                        tag: Const.authButtonHeroTag,
                        child: AppButton(
                          text: 'Continue',
                          isLoading: s.isLoading && s.user.email.isNotNull((_) => true, orElse: (_) => false) && s.user.socials.isNone(),
                          onPressed: () {
                            TextInput.finishAutofillContext();
                            c.read<AuthCubit>().updateSocialsProfile();
                          },
                        ),
                      ),
                    ),
                    //
                    if (context.watch<AuthCubit>().state.user.provider == AuthProvider.apple) ...[
                      0.02.verticalh,
                      //
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (c, s) => AppOutlinedButton(
                          text: 'Later',
                          isLoading: s.isLoading && s.user.phone.isEmpty,
                          splashColor: Colors.black.withOpacity(0.09),
                          padding: EdgeInsets.all(0.007.sw),
                          onPressed: () {},
                        ),
                      ),
                    ],
                    //
                    if (context.watch<AuthCubit>().state.user.provider != AuthProvider.apple)
                      BlocSelector<AuthCubit, AuthState, User?>(
                        selector: (s) => s.user,
                        builder: (c, user) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VerticalSpace(height: 0.06.sw),
                              //
                              const OrWidget(),
                              //
                              VerticalSpace(height: 0.06.sw),

                              OAuthWidgets(
                                cubit: c.read<AuthCubit>(),
                                email: user?.provider != AuthProvider.regular,
                                google: false,
                                apple: false,
                                // google: user?.provider != AuthProvider.google,
                                // apple: user?.provider != AuthProvider.apple,
                              ),
                            ],
                          ),
                        ),
                      ),
                    //
                    0.01.verticalh,
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
