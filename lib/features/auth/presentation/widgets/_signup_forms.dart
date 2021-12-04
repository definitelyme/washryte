part of signup_screen.dart;

class _FormLayout extends StatelessWidget {
  const _FormLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFormInputLabel(text: 'Full Name'),
        //
        NameFormField<AuthCubit, AuthState>(
          prefix: 'First Name',
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          field: (s) => s.user.firstName,
          focus: AuthState.firstNameFocus,
          next: AuthState.lastNameFocus,
          onChanged: (it, str) => it.firstNameChanged(str),
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
          next: AuthState.usernameFocus,
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
          focus: AuthState.phoneFocus,
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
          isNew: false,
          useHero: true,
          heroTag: Const.passwordFieldHeroTag,
          disabled: (s) => s.isLoading,
          validate: (s) => s.validate,
          isObscured: (s) => s.isPasswordHidden,
          field: (s) => s.user.password,
          focus: AuthState.newPasswordFocus,
          response: (s) => s.status,
          errorField: (f) => f.errors?.password,
          onChanged: (fn, str) => fn.passwordChanged(str),
          onToggle: (it) => it.togglePasswordVisibility(),
        ),
      ],
    );
  }
}
