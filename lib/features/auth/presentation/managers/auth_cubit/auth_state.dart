part of auth_cubit.dart;

@freezed
class AuthState extends BaseState with _$AuthState {
  static const int OTP_CODE_LENGTH = 5;
  static final GlobalKey loginFormKey = GlobalKey<FormState>();
  static final GlobalKey signupFormKey = GlobalKey<FormState>();
  static final FocusNode firstNameFocus = FocusNode();
  static final FocusNode lastNameFocus = FocusNode();
  static final FocusNode newEmailFocus = FocusNode();
  static final FocusNode emailFocus = FocusNode();
  static final FocusNode usernameFocus = FocusNode();
  static final FocusNode phoneFocus = FocusNode();
  static final FocusNode newPhoneFocus = FocusNode();
  static final FocusNode tokenFocus = FocusNode();
  static final FocusNode resetPasswordFocus = FocusNode();
  static final FocusNode oldPasswordFocus = FocusNode();
  static final FocusNode newPasswordFocus = FocusNode();
  static final FocusNode passwordFocus = FocusNode();
  static final FocusNode passwordConfirmationFocus = FocusNode();

  const factory AuthState({
    required Password oldPassword,
    required Password confirmPassword,
    required OTPCode code,
    required User user,
    File? selectedPhoto,
    required TextEditingController phoneTextController,
    @Default(0.0) double passwordStrength,
    @Default(false) bool isLoading,
    @Default(false) bool validate,
    @Default(false) bool isGoogleAuthLoading,
    @Default(false) bool isAppleAuthLoading,
    @Default(true) bool isOldPasswordHidden,
    @Default(true) bool isPasswordHidden,
    @Default(false) bool passwordMatches,
    @Default(None()) Option<AppHttpResponse?> status,
  }) = _AuthState;

  const AuthState._();

  factory AuthState.initial() => AuthState(
        user: User.blank(),
        code: OTPCode(null),
        oldPassword: Password(null),
        confirmPassword: Password(null),
        phoneTextController: TextEditingController(),
      );
}
