library home_page.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/features/auth/presentation/managers/managers.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/features/dashboard/presentation/widgets/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/adaptive/adaptive_ink_well.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render HomePage.
class HomePage extends StatelessWidget with AutoRouteWrapper {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: CustomScrollView(
        physics: Utils.physics,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.02.h),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    ImageBox.asset(
                      photo: AppAssets.blackAvatar,
                      width: 0.13.w,
                      height: 0.13.w,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(100),
                      fit: BoxFit.cover,
                      applyConstraintToReplacement: true,
                      replacement: Image.asset(AppAssets.blackAvatar),
                    ),
                    //
                    0.04.horizontalw,
                    //
                    BlocSelector<AuthWatcherCubit, AuthWatcherState, User?>(
                      selector: (s) => s.user,
                      builder: (c, user) => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AdaptiveText(
                            'Welcome back,',
                            fontSize: 16.sp,
                            maxLines: 1,
                            fontWeight: FontWeight.w400,
                            letterSpacing: Utils.letterSpacing,
                          ),
                          AdaptiveText(
                            '${user?.fullName.getOrEmpty}',
                            fontSize: 16.sp,
                            maxLines: 1,
                            fontWeight: FontWeight.w600,
                            letterSpacing: Utils.letterSpacing,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                0.04.verticalh,
                //
                SizedBox(
                  height: 0.18.h,
                  child: Material(
                    borderRadius: 10.br,
                    type: MaterialType.transparency,
                    child: MediaCarousel<Promotion>(
                      items: Promotion.dummies,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      showIndicators: true,
                      builder: (_, i, pv, item) => item.mime.type.maybeWhen(
                        image: () => DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: 10.br,
                            image: DecorationImage(
                              image: ImageBox.asset(
                                photo: item.url.getOrEmpty,
                                width: 1.sw,
                                fit: BoxFit.cover,
                                applyConstraintToReplacement: true,
                                replacement: Utils.nothing,
                              ).provider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: 10.br,
                              color: Colors.black87.withOpacity(0.35),
                            ),
                            child: SizedBox(
                              height: 0.18.h,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.04.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AdaptiveText(
                                    '${item.description.getOrEmpty}',
                                    fontSize: 26.sp,
                                    textColor: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        orElse: () => Utils.nothing,
                      ),
                    ),
                  ),
                ),
                //
                0.09.verticalh,
              ]),
            ),
          ),
          //
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                direction: Axis.horizontal,
                runSpacing: 0.04.w,
                alignment: WrapAlignment.spaceBetween,
                children: InAppService.services
                    .toImmutableList()
                    .mapIndexed(
                      (i, e) => SizedBox(
                        width: 0.28.w,
                        height: 0.16.h,
                        child: Material(
                          color: const Color(0xffE7F1F5),
                          elevation: 5.0,
                          borderRadius: 8.br,
                          child: AdaptiveInkWell(
                            borderRadius: 8.br,
                            onTap: e.onPressed,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  e.asset,
                                  //
                                  0.014.verticalh,
                                  //
                                  AdaptiveText(
                                    e.name,
                                    fontSize: 16.sp,
                                    textColor: e.textColor,
                                    textColorDark: e.textColorDark,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .asList(),
              ),
            ),
          ),
          //
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                0.09.verticalh,
                //
                AppButton(
                  text: 'Request Service',
                  onPressed: () {
                    navigator.navigate(const RequestServiceRoute());
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class InAppService {
  final String name;
  final Widget asset;
  final Color? assetColor;
  final Color? assetColorDark;
  final Color? textColor;
  final Color? textColorDark;
  final VoidCallback? onPressed;

  const InAppService({
    required this.name,
    required this.asset,
    this.assetColor,
    this.assetColorDark,
    this.textColor,
    this.textColorDark,
    this.onPressed,
  });

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is InAppService && (other.name == name) && (other.asset == asset);
  }

  @override
  int get hashCode => name.hashCode ^ asset.hashCode;

  static List<InAppService> get services => [
        InAppService(
          name: 'Wash',
          asset: AppAssets.householdService,
          assetColor: Palette.accentColor,
          assetColorDark: Palette.accentColor,
          textColor: Palette.accentColor,
          textColorDark: Palette.accentColor,
          onPressed: () {},
        ),
        //
        InAppService(
          name: 'Iron',
          asset: AppAssets.ironingService,
          assetColor: Palette.accentColor,
          assetColorDark: Palette.accentColor,
          textColor: Palette.accentColor,
          textColorDark: Palette.accentColor,
          onPressed: () {},
        ),
        //
        InAppService(
          name: 'Starch',
          asset: AppAssets.washingService,
          assetColor: Palette.accentColor,
          assetColorDark: Palette.accentColor,
          textColor: Palette.accentColor,
          textColorDark: Palette.accentColor,
          onPressed: () {},
        ),
      ];
}
