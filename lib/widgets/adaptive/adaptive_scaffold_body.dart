library adaptive_scaffold_body.dart;

import 'package:flutter/material.dart';

/// A stateless widget to render AdaptiveScaffoldBody.
class AdaptiveScaffoldBody extends StatelessWidget {
  final Widget? body;
  final WidgetBuilder? builder;
  final bool materialWrapper;
  final Color? color;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final double elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final TextStyle? textStyle;
  final MaterialType type;

  const AdaptiveScaffoldBody({
    Key? key,
    this.body,
    this.builder,
    this.materialWrapper = false,
    this.color,
    this.borderRadius,
    this.animationDuration = kThemeChangeDuration,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    this.elevation = 0,
    this.shadowColor,
    this.shape,
    this.textStyle,
    this.type = MaterialType.canvas,
  })  : assert((body != null && builder == null) || (body == null && builder != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return materialWrapper
        ? Material(
            elevation: elevation,
            color: color,
            borderRadius: borderRadius,
            animationDuration: animationDuration,
            borderOnForeground: borderOnForeground,
            clipBehavior: clipBehavior,
            shadowColor: shadowColor,
            shape: shape,
            textStyle: textStyle,
            type: type,
            child: builder != null ? Builder(builder: (c) => builder!(c)) : body!,
          )
        : builder != null
            ? Builder(builder: (c) => builder!(c))
            : body!;
  }
}
