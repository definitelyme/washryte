part of signup_screen.dart;

class _FormLayout extends StatelessWidget {
  const _FormLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFormInputLabel(text: 'Display Name'),
        //
        NameFormField<AuthCubit, AuthState>(
          prefix: 'Your Name',
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          field: (s) => s.user.fullName,
          focus: AuthState.firstNameFocus,
          next: AuthState.newEmailFocus,
          onChanged: (it, str) => it.nameChanged(str),
        ),
        //
        VerticalSpace(height: 0.005.h),
        //
        const Material(
          type: MaterialType.transparency,
          child: Hero(
            tag: Const.emailLabelHeroTag,
            child: TextFormInputLabel(text: 'Email Address'),
          ),
        ),
        //
        EmailFormField<AuthCubit, AuthState>(
          useHero: true,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          field: (s) => s.user.email,
          focus: AuthState.newEmailFocus,
          next: AuthState.newPhoneFocus,
          response: (s) => s.status,
          onChanged: (it, str) => it.emailChanged(str),
        ),
        //
        VerticalSpace(height: 0.005.h),
        //
        const TextFormInputLabel(text: 'Phone Number'),
        //
        PhoneFormField<AuthCubit, AuthState>(
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          field: (s) => s.user.phone,
          focus: AuthState.newPhoneFocus,
          next: AuthState.newPasswordFocus,
          controller: (s) => s.phoneTextController,
          response: (s) => s.status,
          onChanged: (cubit, str) => cubit.phoneNumberChanged(str),
        ),
        //
        VerticalSpace(height: 0.005.h),
        //
        const Material(
          type: MaterialType.transparency,
          child: Hero(
            tag: Const.passwordLabelHeroTag,
            child: TextFormInputLabel(text: 'Password'),
          ),
        ),
        //
        PasswordFormField<AuthCubit, AuthState>(
          useHero: true,
          heroTag: Const.passwordFieldHeroTag,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          isObscured: (s) => s.isPasswordHidden,
          field: (s) => s.user.password,
          focus: AuthState.newPasswordFocus,
          next: AuthState.passwordConfirmationFocus,
          response: (s) => s.status,
          errorField: (f) => f.errors?.password,
          onChanged: (fn, str) => fn.passwordChanged(str),
          onToggle: (it) => it.togglePasswordVisibility(),
        ),
        //
        const TextFormInputLabel(text: 'Confirm Password'),
        //
        PasswordFormField<AuthCubit, AuthState>(
          useHero: false,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          isObscured: (s) => s.isPasswordHidden,
          field: (s) => s.user.confirmation,
          focus: AuthState.passwordConfirmationFocus,
          response: (s) => s.status,
          onChanged: (fn, str) => fn.passwordConfirmationChanged(str),
          onToggle: (it) => it.togglePasswordVisibility(),
          suffixMode: (s) => OverlayVisibilityMode.always,
          suffixIcon: (s) => s.user.confirmation.getOrNull == null
              ? Utils.nothing
              : Icon(
                  s.passwordMatches ? Icons.check_circle : Icons.cancel_rounded,
                  color: s.passwordMatches ? Palette.successGreen : Palette.errorRed,
                  size: 25,
                ),
        ),
      ],
    );
  }
}
