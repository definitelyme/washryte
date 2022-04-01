library order_timeline.dart;

import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

/// A stateless widget to render OrderTimeline.
class OrderTimeline extends StatelessWidget {
  final List<String> titles;
  final List<String> subtitles;
  final int currentIndex;
  final Color completedColor;
  final Color pendingColor;
  final int? cancelledIndex;
  final double Function(int)? extent;

  OrderTimeline({
    Key? key,
    required this.titles,
    this.subtitles = const [],
    this.currentIndex = 0,
    this.completedColor = Palette.accentColor,
    this.pendingColor = Palette.neutralGrey,
    this.cancelledIndex,
    this.extent,
  })  : assert(subtitles.isEmpty || titles.length == subtitles.length),
        super(key: key);

  Color getColor(int index) {
    if (index <= currentIndex) {
      return Palette.accentColor;
    } else {
      return pendingColor;
    }
  }

  double get _extent => extent?.call(titles.length) ?? (titles.length * 0.012.h);

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      theme: TimelineThemeData(
        direction: Axis.vertical,
        nodePosition: 0,
        nodeItemOverlap: false,
        connectorTheme: const ConnectorThemeData(
          // space: 20.0,
          thickness: 2.0,
          color: Palette.accentGreen,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemExtentBuilder: (_, __) => _extent,
        addRepaintBoundaries: false,
        nodePositionBuilder: (_, index) {
          if (index > currentIndex) return 0.019;
          return 0;
        },
        oppositeContentsBuilder: (_, __) => Utils.nothing,
        contentsBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(left: 0.04.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdaptiveText(
                titles[index],
                textColor: const Color(0xff282828),
                textColorDark: Palette.text100Dark,
                fontSize: 17.sp,
                minFontSize: 15,
                maxFontSize: 19,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),
              //
              if (subtitles.isNotEmpty && subtitles[index].isNotEmpty)
                Flexible(
                  child: AdaptiveText(
                    subtitles[index],
                    textColor: const Color(0xff6F6F6F),
                    textColorDark: Palette.text100Dark,
                    fontSize: 14.sp,
                    minFontSize: 15,
                    maxFontSize: 17,
                    textAlign: TextAlign.left,
                  ),
                ),
            ],
          ),
        ),
        indicatorBuilder: (_, index) {
          Color color;
          Widget? child;

          if (index == currentIndex) {
            if (cancelledIndex == null) {
              color = completedColor;
              child = const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressBar(strokeWidth: 2.0, color: Colors.white),
              );
            } else {
              color = Palette.errorRed;
              child = const Icon(Icons.close, color: Colors.white, size: 17.0);
            }
          } else if (index < currentIndex) {
            color = completedColor;
            child = const Icon(Icons.check, color: Colors.white, size: 15.0);
          } else {
            color = pendingColor;
          }

          if (index <= currentIndex) {
            return DotIndicator(size: 28.0, color: color, child: child);
          } else {
            return OutlinedDotIndicator(borderWidth: 4.0, color: color);
          }
        },
        connectorBuilder: (_, index, type) {
          if (index > 0) {
            if (index == currentIndex) {
              final prevColor = getColor(index - 1);
              final color = getColor(index);
              List<Color> gradientColors;
              if (type == ConnectorType.start) {
                gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
              } else {
                gradientColors = [prevColor, Color.lerp(prevColor, color, 0.5)!];
              }
              return DecoratedLineConnector(decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColors)));
            } else {
              return SolidLineConnector(color: getColor(index));
            }
          } else {
            return null;
          }
        },
        itemCount: titles.length,
      ),
    );
  }
}
