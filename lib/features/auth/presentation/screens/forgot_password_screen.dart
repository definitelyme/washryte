import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/text_form_input_label.dart';
import 'package:washryte/widgets/vertical_spacer.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render ForgotPasswordScreen.
class ForgotPasswordScreen extends StatelessWidget with AutoRouteWrapper {
  // static final _controller = TextEditingController();
  static const dropdownBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(Utils.inputBorderRadius),
    bottomLeft: Radius.circular(Utils.inputBorderRadius),
  );

  static const dropdownErrorBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Palette.errorRed, width: 1.5),
    borderRadius: dropdownBorderRadius,
  );

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>()..init(),
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null &&
                (c.status.getOrElse(() => null)!.response.maybeMap(
                      error: (f) => f.fold(orElse: () => false),
                      orElse: () => false,
                    ))),
        listener: (c, s) => s.status.fold(
          () => null,
          (th) => th?.response.map(
            error: (f) => PopupDialog.error(message: f.message).render(c),
            success: (p0) => PopupDialog.success(
              message: p0.message,
              listener: (_) => _?.fold(
                dismissed: () => navigator.navigate(const PasswordResetRoute()),
              ),
            ).render(c),
          ),
        ),
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.white),
      child: AdaptiveScaffold(
        adaptiveToolbar: const AdaptiveToolbar(),
        body: CustomScrollView(
          clipBehavior: Clip.antiAlias,
          controller: ScrollController(),
          physics: Utils.physics,
          slivers: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (c, formType) => SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: App.sidePadding,
                ).copyWith(top: App.longest * 0.02),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SafeArea(
                        child: SizedBox(
                          height: 0.6.sw,
                          child: Center(
                            child: SizedBox.square(
                              dimension: 0.4.sw,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Palette.accent20,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0.09.sw),
                                  child: AppAssets.passwordReset,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //
                      VerticalSpace(height: 0.05.sw),
                      //
                      AdaptiveText(
                        'Forgot Password?',
                        fontWeight: FontWeight.w600,
                        fontSize: 26.sp,
                      ),
                      //
                      VerticalSpace(height: 0.03.sw),
                      //
                      AdaptiveText.rich(
                        const TextSpan(children: [
                          TextSpan(text: 'Please enter the '),
                          TextSpan(
                            text: 'phone number',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: ' connected to your '
                                'account to reset password.',
                          ),
                        ]),
                        softWrap: true,
                        wrapWords: true,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.sp,
                      ),
                      //
                      VerticalSpace(height: 0.03.sw),
                      //
                      App.platform.fold(
                        material: () => const Hero(
                          tag: Const.emailLabelHeroTag,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextFormInputLabel(text: 'Phone Number'),
                          ),
                        ),
                        cupertino: () => const SizedBox.shrink(),
                      ),
                      //
                      App.platform.fold(
                        material: () => _phoneInput(),
                        cupertino: () => CupertinoFormSection(
                          children: [_phoneInput()],
                        ),
                      ),
                      //
                      VerticalSpace(height: 0.1.sw),
                      //
                      Align(
                        alignment: Alignment.center,
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (c, s) => CountdownWidget(
                            duration: !s.user.phone.isValid
                                ? const Duration(seconds: 0)
                                : env.flavor.fold(
                                    dev: () => const Duration(minutes: 1),
                                    prod: () => const Duration(minutes: 2, seconds: 5),
                                  ),
                            child: (callback) => Hero(
                              tag: Const.authButtonHeroTag,
                              child: AppButton(
                                text: 'Request OTP',
                                isLoading: s.isLoading,
                                onPressed: () async {
                                  final _isSuccessful = await c.read<AuthCubit>().forgotPassword();
                                  if (_isSuccessful) callback();
                                },
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
          ],
        ),
      ),
    );
  }

  Widget _emailInput() => EmailFormField<AuthCubit, AuthState>(
        disabled: (s) => s.isLoading,
        validate: (s) => s.validate,
        field: (s) => s.user.email,
        response: (s) => s.status,
        errorField: (error) => error.errors?.value,
        onChanged: (it, str) => it.emailChanged(str),
      );

  Widget _phoneInput() => PhoneFormField<AuthCubit, AuthState>(
        disabled: (s) => s.isLoading,
        validate: (s) => s.validate,
        field: (s) => s.user.phone,
        controller: (s) => s.phoneTextController,
        response: (s) => s.status,
        errorField: (error) => error.errors?.value,
        // onPickerBuilder: (cubit, country) {
        //   if (cubit.state.selectedCountry == null) cubit.countryChanged(country);
        // },
        // onCountryChanged: (cubit, country) => cubit.countryChanged(country),
        onChanged: (cubit, str) => cubit.phoneNumberChanged(str),
      );
}
