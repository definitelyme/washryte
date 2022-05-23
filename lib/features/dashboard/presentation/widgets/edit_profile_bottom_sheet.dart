part of profile_page.dart;

/// A stateless widget to render _EditProfileBottomSheet.
class _EditProfileBottomSheet extends StatelessWidget {
  const _EditProfileBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>()..init(loader: true),
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
            info: (i) => PopupDialog.error(message: i.message, show: i.message.isNotEmpty).render(c),
            error: (f) => PopupDialog.error(message: f.message, show: f.show && f.message.isNotEmpty).render(c),
            success: (s) => PopupDialog.success(
              message: s.message,
              listener: (_) => _?.fold(
                dismissed: s.pop ? navigator.pop : null,
              ),
            ).render(c),
          ),
        ),
        child: Builder(
          builder: (c) => WillPopScope(
            onWillPop: () async => c.read<AuthCubit>().state.isLoading == false,
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              controller: ScrollController(),
              physics: Utils.physics,
              scrollDirection: Axis.vertical,
              padding: MediaQuery.of(c).viewInsets,
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
                  Stack(
                    children: [
                      Positioned(
                        top: 5,
                        right: App.sidePadding,
                        child: AnimatedVisibility(
                          visible: c.select((AuthCubit it) => it.state.isLoading),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Utils.circularLoader(color: Palette.accentColor, stroke: 2),
                          ),
                        ),
                      ),
                      //
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: App.platform.fold(
                                    material: () => 0.03.sw,
                                    cupertino: () => App.sidePadding,
                                  ),
                                ),
                                child: Theme.of(c).platform.fold(
                                      material: () => AppIconButton(
                                        onPressed: navigator.pop,
                                        tooltip: 'Back',
                                        elevation: 0.0,
                                        backgroundColor: Theme.of(c).scaffoldBackgroundColor,
                                        child: const Icon(Icons.keyboard_backspace_rounded),
                                      ),
                                      cupertino: () => AdaptiveButton(
                                        text: 'Close',
                                        width: 0.1.sw,
                                        cupertinoHeight: 0.04.sh,
                                        padding: EdgeInsets.zero,
                                        splashColor: App.resolveColor(
                                          Colors.grey.shade300,
                                          dark: Colors.grey.shade800,
                                        ),
                                        fontSize: 18.5.sp,
                                        elevation: 0.0,
                                        backgroundColor: App.resolveColor(
                                          Palette.primaryColor,
                                          dark: Palette.primaryColor,
                                        ),
                                        textColor: Palette.accentColor,
                                        onPressed: navigator.pop,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                          //
                          VerticalSpace(height: 0.02.sw),
                          //
                          Padding(
                            padding: EdgeInsets.only(left: App.sidePadding),
                            child: Headline('Edit Profile'),
                          ),
                          //
                          ImageUploadWidget<AuthCubit, AuthState>(
                            height: (s) => 0.25.sw,
                            isLoading: (s) => s.isLoading,
                            showCenterIcon: true,
                            localFit: BoxFit.fill,
                            networkFit: BoxFit.fill,
                            padding: EdgeInsets.all(App.sidePadding),
                            url: (s) => s.user.photo.getOrNull,
                            selected: (s) => s.selectedPhoto,
                            onCameraClicked: (cubit, source) => cubit.pickImage(source),
                            onGalleryClicked: (cubit, source) => cubit.pickImage(source),
                          ),
                          //
                          VerticalSpace(height: 0.01.sw),
                          //
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFormInputLabel(text: 'Display Name'),
                                //
                                const _FullNameUpdateField(),
                                //
                                VerticalSpace(height: 0.03.sw),
                                //
                                const TextFormInputLabel(text: 'Email Address'),
                                //
                                const _EmailUpdateField(),
                                //
                                VerticalSpace(height: 0.03.sw),
                                //
                                const TextFormInputLabel(text: 'Phone Number'),
                                //
                                const _PhoneNumberField(),
                                //
                                VerticalSpace(height: 0.03.sw),
                                //
                                Hero(
                                  tag: Const.profileLogoutBtnHerotag,
                                  child: AnimatedVisibility(
                                    visible: !c.select(
                                      (AuthCubit it) => it.state.user.phone.getOrNull != null && it.state.isLoading,
                                    ),
                                    replacement: App.loadingSpinningLines,
                                    child: AppButton(
                                      text: 'Save Changes',
                                      onPressed: c.read<AuthCubit>().updateProfile,
                                    ),
                                  ),
                                ),
                                //
                                VerticalSpace(height: App.sidePadding),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullNameUpdateField extends StatelessWidget {
  const _FullNameUpdateField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (c, s) => NameFormField<AuthCubit, AuthState>(
        initial: (s) => s.user.fullName.getOrNull,
        disabled: (s) => s.isLoading,
        validate: (s) => s.validate,
        field: (s) => s.user.fullName,
        focus: AuthState.firstNameFocus,
        next: AuthState.lastNameFocus,
        cupertinoPadding: EdgeInsets.zero,
        onChanged: (it, str) => it.nameChanged(str),
      ),
    );
  }
}

class _EmailUpdateField extends StatelessWidget {
  const _EmailUpdateField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmailFormField<AuthCubit, AuthState>(
      useHero: false,
      initial: (s) => s.user.email.getOrNull,
      disabled: (_) => true,
      readOnly: (_) => true,
      response: (s) => s.status,
      cupertinoPadding: EdgeInsets.zero,
      // onChanged: (it, str) => it.emailChanged(str),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhoneFormField<AuthCubit, AuthState>(
      initial: (s) => s.user.phone.getOrNull,
      disabled: (_) => true,
      readOnly: (_) => true,
      field: (s) => s.user.phone,
      response: (s) => s.status,
      cupertinoPadding: EdgeInsets.zero,
    );
  }
}
