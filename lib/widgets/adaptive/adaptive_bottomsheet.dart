library adaptive_bottomsheet.dart;

import 'package:washryte/utils/utils.dart';
import 'package:flutter/material.dart';

/// A stateless widget to render AdaptiveBottomSheet.
class AdaptiveBottomSheet extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Radius topRadius;

  const AdaptiveBottomSheet({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.topRadius = const Radius.circular(24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      controller: ScrollController(),
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: MediaQuery.of(context).viewInsets,
      child: Material(
        color: App.resolveColor(Palette.primaryColor, dark: Palette.secondaryColor),
        borderRadius: BorderRadius.only(topLeft: topRadius, topRight: topRadius),
        child: child,
      ),
    );
  }
}
