library grouped_layout_item.dart;

import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A stateless widget to render GroupedLayoutCard.
class GroupedLayoutCard extends StatelessWidget {
  final DateTime? dateTime;
  final Widget Function(int) layout;
  final int count;
  final double? verticalGap;

  const GroupedLayoutCard({
    Key? key,
    required this.dateTime,
    required this.layout,
    required this.count,
    this.verticalGap,
  }) : super(key: key);

  String get formattedDate {
    final isToday = DateTime.now().difference(dateTime!).inDays == 0;
    final isYesterday = DateTime.now().difference(dateTime!).inDays == 1;

    if (isToday) return 'Today';
    if (isYesterday)
      return 'Yesterday';
    else
      return '${DateFormat.yMMMEd().format(dateTime!)}';
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: App.sidePadding,
          ).copyWith(top: 0.03.sw),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Headline(
                      '$formattedDate',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        //
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.02.sw),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => Column(
                children: [
                  layout.call(i),
                  //
                  VerticalSpace(height: verticalGap ?? 0.03.sw),
                ],
              ),
              childCount: count,
            ),
          ),
        ),
      ],
    );
  }
}
