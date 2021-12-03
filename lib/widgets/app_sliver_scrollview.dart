library app_sliver_scrollview.dart;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render AppSliverScrollView.
class AppSliverScrollView extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool hasAppBar;
  final bool implyMiddle;
  final bool autoImplyLeading;
  final bool cupertinoAutoImplyLeading;
  final List<Widget> slivers;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool useSafeArea;
  final double? titleTopPadding;
  final double? subtitleTopPadding;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  const AppSliverScrollView({
    Key? key,
    required this.slivers,
    this.title,
    this.subtitle,
    this.hasAppBar = true,
    this.implyMiddle = false,
    this.autoImplyLeading = true,
    this.cupertinoAutoImplyLeading = true,
    this.physics,
    this.controller,
    this.useSafeArea = false,
    this.titleTopPadding,
    this.subtitleTopPadding,
    this.keyboardDismissBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      adaptiveToolbar: hasAppBar
          ? AdaptiveToolbar(
              implyMiddle: implyMiddle,
              implyLeading: autoImplyLeading,
              cupertinoImplyLeading: cupertinoAutoImplyLeading,
            )
          : null,
      body: AdaptiveScaffoldBody(
        body: CustomScrollView(
          shrinkWrap: true,
          physics: physics ?? Utils.physics,
          scrollDirection: Axis.vertical,
          controller: controller ?? ScrollController(),
          keyboardDismissBehavior: keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            if (title != null)
              SliverSafeArea(
                top: useSafeArea,
                left: false,
                right: false,
                sliver: SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: App.sidePadding,
                  ).copyWith(top: titleTopPadding ?? 0.01.sw),
                  sliver: SliverToBoxAdapter(
                    child: Utils.platform_(
                      material: AdaptiveText('$title', style: App.titleStyle),
                      cupertino: VerticalSpace(height: 0.02.sw),
                    ),
                  ),
                ),
              ),
            //
            if (subtitle != null)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: App.sidePadding,
                ).copyWith(top: subtitleTopPadding ?? 0.03.sw),
                sliver: SliverToBoxAdapter(
                  child: AdaptiveText(
                    '$subtitle',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            //
            ...slivers,
          ],
        ),
      ),
    );
  }
}
