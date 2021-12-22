library order_history_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/adaptive/adaptive_ink_well.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render OrderHistoryScreen.
class OrderHistoryScreen extends StatelessWidget with AutoRouteWrapper {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      adaptiveToolbar: const AdaptiveToolbar(title: 'Order History', implyMiddle: true),
      body: CustomScrollView(
        physics: Utils.physics,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: App.sidePadding),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: AdaptiveText(
                      'All time order',
                      maxLines: 1,
                      fontSize: 17.sp,
                      textColor: Palette.accentColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: Utils.letterSpacing,
                    ),
                  ),
                  //
                  const Spacer(),
                  //
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: 6.br,
                      border: Border.all(color: Palette.accentColor, width: 1),
                    ),
                    child: AdaptiveInkWell(
                      borderRadius: 6.br,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Utils.platform_(
                                material: Icons.calendar_today,
                                cupertino: CupertinoIcons.calendar,
                              ),
                              size: 20,
                              color: Palette.accentColor,
                            ),
                            //
                            0.02.horizontalw,
                            //
                            AdaptiveText(
                              'Select Date',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
          SliverToBoxAdapter(
            child: 0.02.verticalh,
          ),
          //
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => AdaptiveListTile(
                material: true,
                shape: RoundedRectangleBorder(borderRadius: 8.br),
                contentPadding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                horizontalTitleGap: 6,
                leading: Icon(Icons.history),
                title: AdaptiveText(
                  'Two wash and ${i + 1} starch',
                  maxLines: 1,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: Utils.letterSpacing,
                  softWrap: false,
                ),
                subtitle: AdaptiveText(
                  '30 Oct, 2021',
                  maxLines: 1,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  letterSpacing: Utils.letterSpacing,
                  softWrap: false,
                ),
                trailing: Material(
                  borderRadius: 7.br,
                  color: const Color(0xffE7F1F5),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.chevron_right_rounded),
                  ),
                ),
                onTap: () {},
              ),
              childCount: 6,
            ),
            itemExtent: 0.09.h,
          ),
        ],
      ),
    );
  }
}
