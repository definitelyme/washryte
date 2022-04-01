import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Key? scaffoldKey;
  final AdaptiveToolbar? adaptiveToolbar;
  final Widget? body;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? overlayStyle;
  final PlatformNavBar? adaptiveBottomNav;
  final IndexedWidgetBuilder? cupertinoTabBuilder;
  final CupertinoPageScaffoldData Function(BuildContext, PlatformTarget)? cupertino;
  final MaterialScaffoldData Function(BuildContext, PlatformTarget)? material;
  final bool iosContentBottomPadding;
  final bool iosContentPadding;

  const AdaptiveScaffold({
    this.scaffoldKey,
    this.adaptiveToolbar,
    this.adaptiveBottomNav,
    this.body,
    this.backgroundColor,
    this.cupertinoTabBuilder,
    this.overlayStyle,
    this.cupertino,
    this.material,
    this.iosContentBottomPadding = false,
    this.iosContentPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle ?? App.systemUIOverlayStyle(context),
      child: PlatformScaffold(
        widgetKey: scaffoldKey,
        appBar: adaptiveToolbar?.build(),
        body: body,
        backgroundColor: backgroundColor ?? App.resolveColor(Palette.neutralF9, dark: Palette.secondaryColor),
        bottomNavBar: adaptiveBottomNav,
        cupertinoTabChildBuilder: cupertinoTabBuilder,
        iosContentBottomPadding: iosContentBottomPadding,
        iosContentPadding: iosContentPadding,
        cupertino: cupertino,
        material: material,
      ),
    );
  }
}
