library animated_visibility.dart;

import 'package:washryte/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A stateless widget to render AnimatedVisibility.
class AnimatedVisibility extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Widget replacement;
  final Duration duration;

  const AnimatedVisibility({
    Key? key,
    this.visible = true,
    required this.child,
    this.replacement = Utils.nothing,
    this.duration = Utils.crossFadeDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: duration,
      layoutBuilder: Utils.crossFadeLayoutBuilder,
      crossFadeState: visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      secondChild: replacement,
      firstChild: child,
    );
  }
}
