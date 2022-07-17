import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:washryte/utils/utils.dart';

mixin AppAssets {
  static const ASSETS_DIR = 'assets';
  static const SVG_DIR = '$ASSETS_DIR/svgs';
  static const IMAGES_DIR = '$ASSETS_DIR/images';
  static const RAW_DIR = '$ASSETS_DIR/raw';
  // Sub-folders
  //////////////  IMAGES  ////////////
  static const String ONBOARDING_IMAGES_DIR = '$IMAGES_DIR/onboarding';
  static const String DASHBOARD_IMAGES_DIR = '$IMAGES_DIR/dashboard';

  /////////////  SVGS /////////////
  static const String AUTH_SVG_DIR = '$SVG_DIR/auth';
  static const String ONBOARDING_SVG_DIR = '$SVG_DIR/onboarding';
  static const String DASHBOARD_SVG_DIR = '$SVG_DIR/dashboard';
  static const String AVATAR_IMAGES_DIR = '$DASHBOARD_IMAGES_DIR/avatars';

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  /// LOGO
  static const String logo = '$IMAGES_DIR/logo/logo.png';

  // ONBOARDING
  static const String onboarding = '$ONBOARDING_IMAGES_DIR/onboarding.png';

  /// AUTHENTICATION (Login/Signup)
  static const String _passwordReset = '$AUTH_SVG_DIR/password_reset_pana.svg';

  /// USER
  static const String user = '$IMAGES_DIR/user.png';
  static const String female = '$IMAGES_DIR/female.png';
  static const String unnamed = '$IMAGES_DIR/unnamed.png';
  static const String avatarImg = '$IMAGES_DIR/avatar_png.png';
  static const String businessManAvatar = '$AVATAR_IMAGES_DIR/business_man_avatar.png';
  static const String businessLadyAvatar = '$AVATAR_IMAGES_DIR/business_woman_avatar.png';
  static const String femaleAvatar = '$AVATAR_IMAGES_DIR/female_avatar.png';
  static const String dudeAvatar = '$AVATAR_IMAGES_DIR/dude_avatar.png';
  static const String blackAvatar = '$AVATAR_IMAGES_DIR/black-dude.png';
  static const String guestAvatarSvg = '$DASHBOARD_SVG_DIR/guest_user.svg';
  static const String guestAvatarPng = '$DASHBOARD_IMAGES_DIR/guest_user.png';

  /// DASHBOARD - SVG
  static const String dashboardHomeAsset = '$DASHBOARD_SVG_DIR/home.svg';
  static const String dashboardTimelineAsset = '$DASHBOARD_SVG_DIR/timeline.svg';
  static const String dashboardNotificationAsset = '$DASHBOARD_SVG_DIR/notification.svg';
  static const String _ironingService = '$DASHBOARD_SVG_DIR/ironing_service.svg';
  static const String _householdService = '$DASHBOARD_SVG_DIR/household_service.svg';
  static const String _washingService = '$DASHBOARD_SVG_DIR/washing_service.svg';
  static const String _riderEnroute = '$DASHBOARD_SVG_DIR/rider_enroute_pana.svg';
  static const String _balloons = '$DASHBOARD_SVG_DIR/birthday_balloons.svg';

  /// DASHBAORD - PNG
  static const String carouselImg1 = '$DASHBOARD_IMAGES_DIR/carousel_img_1.png';
  static const String carouselImg2 = '$DASHBOARD_IMAGES_DIR/carousel_img_2.png';

  // EMPTY STATES
  static const String _noConnectivity = '$DASHBOARD_SVG_DIR/no_connectivity.svg';
  static const String _noHstory = '$DASHBOARD_SVG_DIR/no_history.svg';

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  ///
  static const List<String> images = [
    logo,
    female,
    unnamed,
    user,
    onboarding,
    businessManAvatar,
    businessLadyAvatar,
    femaleAvatar,
    dudeAvatar,
    guestAvatarPng,
  ];

  static const List<String> svgs = [
    guestAvatarSvg,
    _noConnectivity,
    _passwordReset,
    dashboardHomeAsset,
    dashboardTimelineAsset,
    dashboardNotificationAsset,
    _ironingService,
    _householdService,
    _washingService,
    _riderEnroute,
    _balloons,
  ];

  static SvgPicture get google => SvgPicture.asset(
        '$AUTH_SVG_DIR/google.svg',
        height: 23,
        width: 23,
        fit: BoxFit.contain,
      );

  static SvgPicture facebook([Color? color]) => SvgPicture.asset(
        '$AUTH_SVG_DIR/facebook.svg',
        height: 23,
        width: 23,
        color: color ??
            Utils.foldTheme(
              light: () => null,
              dark: () => Colors.white70,
            ),
        fit: BoxFit.contain,
      );

  static SvgPicture twitter([Color? color]) => SvgPicture.asset(
        '$AUTH_SVG_DIR/twitter.svg',
        height: 23,
        width: 23,
        color: color ??
            Utils.foldTheme(
              light: () => null,
              dark: () => Colors.white70,
            ),
        fit: BoxFit.contain,
      );

  static SvgPicture apple([Color? color]) => SvgPicture.asset(
        '$AUTH_SVG_DIR/apple.svg',
        height: 22,
        width: 22,
        color: color ??
            Utils.foldTheme(
              light: () => null,
              dark: () => Colors.white70,
            ),
        fit: BoxFit.contain,
      );

  static SvgPicture emailRegular([Color? color]) => SvgPicture.asset(
        '$AUTH_SVG_DIR/mail_to.svg',
        height: 22,
        width: 22,
        color: color,
        fit: BoxFit.contain,
      );

  static SvgPicture pdf = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/pdf.svg',
    height: 40,
    width: 40,
    fit: BoxFit.contain,
  );

  static SvgPicture docx = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/docs.svg',
    height: 40,
    width: 40,
    fit: BoxFit.contain,
  );

  static SvgPicture cameraOutlined = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/camera_outlined.svg',
    height: 25,
    width: 25,
    color: Colors.white,
    fit: BoxFit.contain,
  );

  static SvgPicture cameraColored = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/camera_colored.svg',
    height: 25,
    width: 25,
    fit: BoxFit.contain,
  );

  static SvgPicture galleryOutlined = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/gallery_outlined.svg',
    height: 25,
    width: 25,
    color: Colors.white,
    fit: BoxFit.contain,
  );

  static SvgPicture galleryColored = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/gallery_colored.svg',
    height: 25,
    width: 25,
    fit: BoxFit.contain,
  );

  static SvgPicture bell = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/bell.svg',
    height: 20,
    width: 20,
    color: Colors.grey,
    fit: BoxFit.contain,
  );

  static SvgPicture bankBuilding = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/bank-building.svg',
    height: 23,
    width: 23,
    color: App.resolveColor(
      Palette.accentColor,
      dark: Colors.white70,
    ),
    fit: BoxFit.contain,
  );

  static SvgPicture cardFunding = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/fund-with-card.svg',
    height: 23,
    width: 23,
    color: App.resolveColor(
      Palette.accentColor,
      dark: Colors.white70,
    ),
    fit: BoxFit.contain,
  );

  static SvgPicture atm = SvgPicture.asset(
    '$DASHBOARD_SVG_DIR/atm.svg',
    height: 23,
    width: 23,
    color: App.resolveColor(
      Palette.accentColor,
      dark: Colors.white70,
    ),
    fit: BoxFit.contain,
  );

  static SvgPicture noConnectivity([Size size = const Size(23, 23)]) => SvgPicture.asset(
        _noConnectivity,
        height: size.height,
        width: size.width,
        color: App.resolveColor(
          Palette.neutralC7,
          dark: Colors.white70,
        ),
        fit: BoxFit.contain,
      );

  static SvgPicture noHistory([Size size = const Size(23, 23)]) => SvgPicture.asset(
        _noHstory,
        height: size.height,
        width: size.width,
        color: App.resolveColor(
          Palette.neutralC7,
          dark: Colors.white70,
        ),
        fit: BoxFit.contain,
      );

  static SvgPicture passwordReset = SvgPicture.asset(
    _passwordReset,
    fit: BoxFit.contain,
  );

  static SvgPicture dashboardHome([Size size = const Size(25, 25)]) => SvgPicture.asset(
        dashboardHomeAsset,
        width: size.width,
        height: size.height,
        fit: BoxFit.contain,
      );

  static SvgPicture dashboardTimeline([Size size = const Size(25, 25)]) => SvgPicture.asset(
        dashboardTimelineAsset,
        width: size.width,
        height: size.height,
        fit: BoxFit.contain,
      );

  static SvgPicture dashboardNotification([Size size = const Size(25, 25)]) => SvgPicture.asset(
        dashboardNotificationAsset,
        width: size.width,
        height: size.height,
        fit: BoxFit.contain,
      );

  static SvgPicture ironingService = SvgPicture.asset(
    _ironingService,
    fit: BoxFit.contain,
  );

  static SvgPicture householdService = SvgPicture.asset(
    _householdService,
    fit: BoxFit.contain,
  );

  static SvgPicture washingService = SvgPicture.asset(
    _washingService,
    fit: BoxFit.contain,
  );

  static SvgPicture riderEnroute = SvgPicture.asset(
    _riderEnroute,
    fit: BoxFit.contain,
  );

  static SvgPicture balloons = SvgPicture.asset(
    _balloons,
    fit: BoxFit.contain,
  );
}
