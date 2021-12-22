library insight_page.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render InsightPage.
class InsightPage extends StatelessWidget with AutoRouteWrapper {
  const InsightPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      adaptiveToolbar: const AdaptiveToolbar(title: 'Track Order', implyMiddle: true),
      body: CustomScrollView(
        physics: Utils.physics,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            sliver: SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: AdaptiveListTile(
                          material: true,
                          shape: RoundedRectangleBorder(borderRadius: 8.br),
                          leading: AppAssets.dashboardTimeline(Size.square(0.08.w)),
                          tileColor: const Color(0xFFE7F1F5),
                          horizontalTitleGap: 8,
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 0.008.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AdaptiveText(
                                        '5 mins ago',
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      //
                                      0.006.verticalh,
                                      //
                                      AdaptiveText(
                                        'Wahing and ironing',
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: Utils.letterSpacing,
                                      ),
                                    ],
                                  ),
                                ),
                                //
                                Flexible(
                                  child: AdaptiveText(
                                    'In progress',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    style: const TextStyle(fontStyle: FontStyle.italic),
                                    letterSpacing: Utils.letterSpacing,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: AdaptiveText(
                            'Track',
                            fontSize: 16.sp,
                            textColor: Palette.accentColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: Utils.letterSpacing,
                          ),
                          onTap: () {},
                        ),
                      ),
                      //
                      0.013.verticalh,
                    ],
                  ),
                ),
                childCount: 3,
              ),
              itemExtent: 0.125.h,
            ),
          ),
        ],
      ),
    );
  }
}
