library disabled.dart;

import 'package:flutter/material.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render Disabled.
class Disabled extends StatelessWidget {
  final bool disabled;
  final bool isLoading;
  final double opacity;
  final Duration duration;
  final Curve curve;
  final Widget child;
  final bool alwaysIncludeSemantics;

  const Disabled({
    Key? key,
    this.disabled = false,
    this.isLoading = false,
    this.opacity = 0.5,
    this.curve = Curves.easeInOutCubic,
    this.duration = const Duration(milliseconds: 300),
    this.alwaysIncludeSemantics = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedVisibility(
      visible: !isLoading,
      replacement: App.loadingSpinningLines,
      child: AnimatedOpacity(
        opacity: disabled ? opacity : 1.0,
        duration: duration,
        curve: curve,
        alwaysIncludeSemantics: alwaysIncludeSemantics,
        child: IgnorePointer(
          ignoring: disabled,
          child: child,
        ),
      ),
    );
  }
}
