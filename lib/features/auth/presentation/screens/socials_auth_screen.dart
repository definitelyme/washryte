library socials_auth_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/auth/presentation/widgets/oauth_widgets.dart';
import 'package:washryte/features/auth/presentation/widgets/pps_terms_widget.dart';
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
            (c.status.getOrElse(() => null) != null &&
                (c.status.getOrElse(() => null)!.response.maybeMap(
                      error: (f) => f.fold(
                        is41101: () {
                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            if (navigator.current.name != DashboardRoute.name) navigator.popAndPush(const SocialsAuthRoute());
                          });
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
  State<SocialsAuthScreen> createState() => _SocialsAuthScreenState();
}

class _SocialsAuthScreenState extends State<SocialsAuthScreen> {
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final usernameFocus = FocusNode();
  final phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
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
                AdaptiveText(
                  'Continue with socials',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: Utils.letterSpacing,
                ),
                //
                VerticalSpace(height: 0.03.sw),
                //
                BlocSelector<AuthCubit, AuthState, User>(
                  selector: (s) => s.user,
                  builder: (c, user) => AdaptiveText(
                    'You are continuing with ${user.email.getOrNull ?? 'socials'}',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: Utils.letterSpacing,
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocSelector<AuthCubit, AuthState, User?>(
                        selector: (s) => s.user,
                        builder: (c, user) => GestureDetector(
                          onTap: () => user?.provider.when(
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
                          visible: s.isLoading && !s.user.email.isValid,
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressBar.adaptive(
                              strokeWidth: 2.3,
                              width: 21,
                              height: 21,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                VerticalSpace(height: 0.02.sw),
                //
                AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFormInputLabel(text: 'First Name'),
                                //
                                NameFormField<AuthCubit, AuthState>(
                                  initial: (s) => s.user.firstName.getOrEmpty,
                                  disabled: (s) => s.isLoading,
                                  validate: (s) => s.validate,
                                  field: (s) => s.user.firstName,
                                  focus: firstNameFocus,
                                  next: lastNameFocus,
                                  onChanged: (it, str) => it.firstNameChanged(str),
                                ),
                              ],
                            ),
                          ),
                          //
                          HorizontalSpace(width: 0.03.sw),
                          //
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFormInputLabel(text: 'Last Name'),
                                //
                                NameFormField<AuthCubit, AuthState>(
                                  initial: (s) => s.user.lastName.getOrEmpty,
                                  prefix: 'Last Name',
                                  disabled: (s) => s.isLoading,
                                  validate: (s) => s.validate,
                                  field: (s) => s.user.lastName,
                                  focus: lastNameFocus,
                                  next: usernameFocus,
                                  onChanged: (it, str) => it.lastNameChanged(str),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //
                      VerticalSpace(height: 0.04.sw),
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
                          validate: (s) => s.validate,
                          response: (s) => s.status,
                        ),
                      ),
                      //
                      VerticalSpace(height: 0.04.sw),
                      //
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormInputLabel(text: 'Phone Number'),
                      ),
                      //
                      PhoneFormField<AuthCubit, AuthState>(
                        initial: (s) => s.user.phone.getOrEmpty,
                        disabled: (s) => s.isLoading,
                        validate: (s) => s.validate,
                        field: (s) => s.user.phone,
                        focus: phoneFocus,
                        borderRadius: BorderRadius.circular(100),
                        controller: (s) => s.phoneTextController,
                        response: (s) => s.status,
                        onChanged: (cubit, str) => cubit.phoneNumberChanged(str),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          //
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.06.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (c, s) => Hero(
                    tag: Const.authButtonHeroTag,
                    child: AppButton(
                      text: 'Continue',
                      isLoading: s.isLoading && s.user.email.isNotNull((_) => true, orElse: (_) => false),
                      onPressed: () {
                        TextInput.finishAutofillContext();
                        c.read<AuthCubit>().updateSocialsProfile();
                      },
                    ),
                  ),
                ),
                //
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
                        //
                        if (user != null)
                          user.provider.when(
                            regular: () => Utils.nothing,
                            google: () => OAuthWidgets(
                              cubit: c.read<AuthCubit>(),
                              google: false,
                              email: true,
                              apple: true,
                            ),
                            apple: () => OAuthWidgets(
                              cubit: c.read<AuthCubit>(),
                              apple: false,
                              email: true,
                              google: true,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                //
                VerticalSpace(height: 0.04.sw),
                //
                const PPsTermsWidget(),
                //
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
