library animated_sliver_visibility.dart;

import 'package:washryte/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A stateless widget to render AnimatedSliverVisibility.
class AnimatedSliverVisibility extends StatelessWidget {
  final bool visible;
  final Widget sliver;
  final Widget? sliverReplacement;
  final Duration duration;

  const AnimatedSliverVisibility({
    Key? key,
    this.visible = true,
    required this.sliver,
    this.sliverReplacement,
    this.duration = Utils.crossFadeDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedCrossFade(
        duration: duration,
        layoutBuilder: Utils.crossFadeLayoutBuilder,
        crossFadeState: visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        secondChild: _ScrollWrapper(
          sliverChild: true,
          child: SliverToBoxAdapter(child: sliverReplacement ?? Utils.nothing),
        ),
        firstChild: _ScrollWrapper(
          sliverChild: true,
          child: sliver,
        ),
      ),
    );
  }
}

class _ScrollWrapper extends StatelessWidget {
  final Widget child;
  final bool sliverChild;

  const _ScrollWrapper({
    Key? key,
    required this.child,
    this.sliverChild = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        if (!sliverChild) SliverToBoxAdapter(child: child),
        if (sliverChild) child,
      ],
    );
  }
}
