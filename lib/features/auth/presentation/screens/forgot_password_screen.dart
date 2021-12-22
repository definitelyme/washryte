import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render ForgotPasswordScreen.
class ForgotPasswordScreen extends StatefulWidget with AutoRouteWrapper {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();

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
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with AutomaticKeepAliveClientMixin<ForgotPasswordScreen> {
  @override
  bool get wantKeepAlive => true;

  Widget _emailInput() => EmailFormField<AuthCubit, AuthState>(
        disabled: (s) => s.isLoading,
        validate: (s) => s.validate,
        field: (s) => s.user.email,
        response: (s) => s.status,
        errorField: (error) => error.errors?.value,
        onChanged: (it, str) => it.emailChanged(str),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Theme(
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.white),
      child: AdaptiveScaffold(
        body: NestedScrollView(
          controller: ScrollController(),
          floatHeaderSlivers: true,
          physics: Utils.physics,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                stretch: false,
                snap: false,
                floating: true,
                primary: true,
                forceElevated: innerBoxIsScrolled,
                elevation: 0,
                expandedHeight: 0.35.h,
                backgroundColor: Colors.transparent,
                leading: LayoutBuilder(
                  builder: (context, constraints) => Center(
                    child: Material(
                      color: Colors.white,
                      elevation: 0,
                      borderRadius: BorderRadius.circular(Utils.inputBorderRadius),
                      child: InkWell(
                        onTap: navigator.pop,
                        borderRadius: BorderRadius.circular(Utils.inputBorderRadius),
                        child: const Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Icon(Icons.keyboard_backspace_rounded, color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
                flexibleSpace: Stack(
                  children: [
                    const Positioned.fill(child: SizedBox.expand()),
                    //
                    Positioned.fill(
                      bottom: 0.09.h,
                      child: const FlexibleSpaceBar(
                        stretchModes: [
                          StretchMode.zoomBackground,
                          StretchMode.blurBackground,
                          StretchMode.fadeTitle,
                        ],
                        background: DecoratedBox(
                          decoration: BoxDecoration(color: Palette.accentColor),
                        ),
                      ),
                    ),
                    //
                    Positioned.fill(
                      top: 0.06.h,
                      left: 0.1.w,
                      right: 0.1.w,
                      bottom: 0.03.h,
                      child: AnimatedVisibility(
                        visible: !innerBoxIsScrolled,
                        child: AppAssets.passwordReset,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: Builder(
            builder: (ctx) => CustomScrollView(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                ),
                //
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 0.06.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        AdaptiveText(
                          'Forgot Password?',
                          fontWeight: FontWeight.w600,
                          fontSize: 26.sp,
                        ),
                        //
                        VerticalSpace(height: 0.015.h),
                        //
                        AdaptiveText(
                          'Enter the email address you used in opening an account',
                          softWrap: true,
                          wrapWords: true,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.w400,
                          fontSize: 17.sp,
                        ),
                        //
                        VerticalSpace(height: 0.02.h),
                        //
                        App.platform.fold(
                          material: () => const Hero(
                            tag: Const.emailLabelHeroTag,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormInputLabel(text: 'Email'),
                            ),
                          ),
                          cupertino: () => const SizedBox.shrink(),
                        ),
                        //
                        App.platform.fold(
                          material: () => _emailInput(),
                          cupertino: () => CupertinoFormSection(
                            children: [_emailInput()],
                          ),
                        ),
                        //
                        VerticalSpace(height: 0.05.h),
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
                                  text: 'Send Reset Link',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
