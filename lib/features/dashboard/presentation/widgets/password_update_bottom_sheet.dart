part of profile_page.dart;

/// A stateless widget to render _PasswordUpdateBottomSheet.
class _PasswordUpdateBottomSheet extends StatelessWidget {
  const _PasswordUpdateBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null && (c.status.getOrElse(() => null)!.response.maybeMap(orElse: () => false))),
        listener: (c, s) => s.status.fold(
          () => null,
          (th) => th?.response.map(
            info: (i) => PopupDialog.info(message: i.message).render(c),
            error: (f) => PopupDialog.error(message: f.message, show: f.show).render(c),
            success: (s) => PopupDialog.success(
              message: s.message,
              listener: (_) => _?.fold(
                dismissed: () => s.pop ? navigator.popUntilRouteWithName(DashboardRoute.name) : null,
              ),
            ).render(c),
          ),
        ),
        child: AdaptiveBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalSpace(height: 0.04.sw),
              //
              ClipRRect(
                borderRadius: BorderRadius.circular(Utils.cardRadius),
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: SizedBox(height: 0.015.sw, width: 0.2.sw),
                ),
              ),
              //
              VerticalSpace(height: 0.03.sw),
              //
              Padding(
                padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                child: const _FormLayout(),
              ),
              //
              VerticalSpace(height: 0.04.sw),
              //
              SafeArea(
                top: false,
                left: false,
                right: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (p, c) => p.isLoading != c.isLoading,
                    builder: (c, s) => Hero(
                      tag: Const.profileLogoutBtnHerotag,
                      child: AppButton(
                        text: 'Save Changes',
                        isLoading: s.isLoading,
                        onPressed: c.read<AuthCubit>().updatePassword,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFormInputLabel(text: 'Old Password'),
        //
        PasswordFormField<AuthCubit, AuthState>(
          isNew: false,
          useHero: false,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          isObscured: (s) => s.isOldPasswordHidden,
          field: (s) => s.oldPassword,
          focus: AuthState.oldPasswordFocus,
          next: AuthState.passwordFocus,
          response: (s) => s.status,
          errorField: (f) => f.errors?.oldPassword,
          onChanged: (fn, str) => fn.oldPasswordChanged(str),
          onToggle: (it) => it.toggleOldPasswordVisibility(),
        ),
        //
        VerticalSpace(height: 0.03.sw),
        //
        const TextFormInputLabel(text: 'New Password'),
        //
        PasswordFormField<AuthCubit, AuthState>(
          isNew: true,
          useHero: false,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          isObscured: (s) => s.isPasswordHidden,
          field: (s) => s.user.password,
          focus: AuthState.passwordFocus,
          next: AuthState.passwordConfirmationFocus,
          response: (s) => s.status,
          errorField: (f) => f.errors?.password,
          onChanged: (fn, str) => fn.passwordChanged(str),
          onToggle: (it) => it.togglePasswordVisibility(),
        ),
        //
        VerticalSpace(height: 0.03.sw),
        //
        const TextFormInputLabel(text: 'Confirm New Password'),
        //
        PasswordFormField<AuthCubit, AuthState>(
          isNew: true,
          useHero: false,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          isObscured: (s) => s.isPasswordHidden,
          field: (s) => s.user.confirmation,
          focus: AuthState.passwordConfirmationFocus,
          response: (s) => s.status,
          onChanged: (fn, str) => fn.passwordConfirmationChanged(str),
          suffixIcon: (s) => Visibility(
            visible: s.user.confirmation.isValid && s.isPasswordHidden,
            child: Padding(
              padding: Utils.platform_(cupertino: const EdgeInsets.only(right: 10), material: EdgeInsets.zero)!,
              child: Icon(
                s.passwordMatches ? Icons.check_circle : Icons.cancel_rounded,
                color: s.passwordMatches ? Palette.successGreen : Palette.errorRed,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
