library tracking_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/features/dashboard/presentation/widgets/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

/// A stateless widget to render TrackingScreen.
class TrackingScreen extends StatefulWidget with AutoRouteWrapper {
  final ServiceRequest request;

  const TrackingScreen(this.request, {Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RequestCubit>()..show(request),
      child: BlocListener<RequestCubit, RequestState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null && (c.status.getOrElse(() => null)!.response.maybeMap(orElse: () => false))),
        listener: (c, s) => s.status.fold(
          () => null,
          (it) => it?.response.map(
            info: (i) => PopupDialog.info(message: i.message, show: i.message.isNotEmpty).render(c),
            error: (f) => PopupDialog.error(message: f.message, show: f.show && f.message.isNotEmpty).render(c),
            success: (s) => PopupDialog.success(
              message: s.message,
              listener: (status) => status?.fold(
                dismissed: () {
                  if (s.pop && App.currentRoute == TrackingRoute.name) navigator.popUntilRoot();
                },
              ),
            ).render(c),
          ),
        ),
        child: this,
      ),
    );
  }

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  int getCurrentIndex(OrderStatus status) {
    return status.maybeWhen(
      pending: () => 0,
      enroute: () => 1,
      processing: () => 2,
      paid: () => 3,
      washing: () => 3,
      done: () => 5,
      delivering: () => 4,
      delivered: () => 6,
      cancelled: () => 3,
      orElse: () => 1,
    );
  }

  Future<bool> maybePop() {
    final cubit = context.read<RequestCubit>();
    if (cubit.state.request.status != OrderStatus.delivered && cubit.state.request.status != OrderStatus.cancelled) cubit.updateBalance();

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: maybePop,
      child: AdaptiveScaffold(
        adaptiveToolbar: const AdaptiveToolbar(implyMiddle: false),
        body: BlocBuilder<RequestCubit, RequestState>(
          builder: (c, s) => AnimatedVisibility(
            visible: !s.isFetchingSingle,
            replacement: Center(
              child: ImageBox.asset(
                photo: AppAssets.logo,
                width: 0.3.w,
                height: 0.3.w,
                borderRadius: BorderRadius.zero,
                useDefaultRadius: false,
                fit: BoxFit.contain,
              ),
            ),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverSafeArea(
                  left: false,
                  right: false,
                  bottom: false,
                  sliver: SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.01.h),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        AdaptiveText.rich(
                          TextSpan(children: [
                            const TextSpan(text: 'Order Placed: '),
                            TextSpan(
                              text: '${timeago.format(widget.request.createdAt!)}',
                              style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: Utils.letterSpacing),
                            ),
                          ]),
                          maxLines: 1,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: Utils.letterSpacing,
                        ),
                        //
                        AdaptiveText.rich(
                          TextSpan(children: [
                            const TextSpan(text: 'Address: '),
                            TextSpan(
                              text: '${widget.request.address.getOrNull}',
                              style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: Utils.letterSpacing),
                            ),
                          ]),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        //
                        0.02.verticalh,
                      ]),
                    ),
                  ),
                ),
                //
                SliverSafeArea(
                  top: false,
                  left: false,
                  right: false,
                  sliver: SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        s.request.status.maybeWhen(
                          cancelled: () => OrderTimeline(
                            titles: [
                              'Order Received',
                              'Rider on the way',
                              'Clothes delivered for sorting',
                              'Order Cancelled',
                            ],
                            subtitles: [
                              '',
                              'Rider is on the way to pick up your order.',
                              'Order has been delivered. We are currently sorting your clothes and preparing an invoice.',
                              'You cancelled the order.',
                            ],
                            cancelledIndex: 1,
                            extent: (length) => length * 0.03.h,
                            currentIndex: getCurrentIndex(s.request.status),
                          ),
                          orElse: () => OrderTimeline(
                            titles: s.request.type.when(
                              pickup: () => [
                                'Order Received',
                                'Rider on the way',
                                'Clothes delivered for sorting',
                                'Washing & Cleaning',
                                'Ready for pickup',
                              ],
                              delivery: () => [
                                'Order Received',
                                'Rider on the way',
                                'Clothes delivered for sorting',
                                'Washing & Cleaning',
                                'Rider enroute to address',
                                'Order Delivered',
                              ],
                            ),
                            subtitles: s.request.type.when(
                              pickup: () => [
                                '',
                                'Rider is on the way to pick up your order.',
                                'Order has been delivered. We are currently sorting your clothes and preparing an invoice.',
                                'Your order is currently undergoing all necessary service.',
                                'Your order ready for pickup. Thanks for your patience.',
                              ],
                              delivery: () => [
                                '',
                                'Rider is on the way to pick up your order.',
                                'Order has been received. We are currently sorting your clothes and preparing an invoice.',
                                'Your order is currently undergoing all necessary service.',
                                'A rider is on the way to ${widget.request.address.getOrNull}.',
                                'Thanks for your patience.',
                              ],
                            ),
                            extent: (length) => s.request.type.when(
                              pickup: () => length * 0.018.h,
                              delivery: () => length * 0.015.h,
                            ),
                            currentIndex: getCurrentIndex(s.request.status),
                          ),
                        ),
                        //
                        s.request.status.maybeWhen(
                          enroute: () => AppAssets.riderEnroute,
                          delivering: () => AppAssets.riderEnroute,
                          processing: () {
                            if (s.request.amount.getOrNull <= 0) return Utils.nothing;

                            return Material(
                              elevation: 7,
                              borderRadius: 10.br,
                              color: App.resolveColor(Palette.cardColorLight, dark: Palette.cardColorDark),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.06.w, vertical: 0.03.h),
                                child: Column(
                                  children: [
                                    AdaptiveText.rich(
                                      TextSpan(children: [
                                        const TextSpan(text: 'Your service charge is '),
                                        TextSpan(
                                          text: '${s.request.amount.getOrNull}'.asCurrency(),
                                          style: const TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        const TextSpan(text: '. Proceed to pay from your wallet.'),
                                      ]),
                                      softWrap: true,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                    //
                                    0.03.verticalh,
                                    //
                                    ...s.request.services
                                        .map(
                                          (it) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                // mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 10,
                                                    child: AdaptiveText(
                                                      '${it.name.getOrEmpty} x ${it.quantity.getOrNull}',
                                                      // 'eriuhfi oeifo eiorfjerfk operjfoerfj oe iuhe9ihe rfie hvioer',
                                                      maxLines: 1,
                                                      minFontSize: 14,
                                                      maxFontSize: 17,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w500,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  //
                                                  // 0.02.horizontalw,
                                                  //
                                                  // Expanded(
                                                  //   flex: 2,
                                                  //   child: DotWidget(
                                                  //     max: 70,
                                                  //     dashColor: (i) => Colors.grey,
                                                  //   ),
                                                  // ),
                                                  //
                                                  // 0.02.horizontalw,
                                                  //
                                                  Flexible(
                                                    flex: 4,
                                                    child: AdaptiveText(
                                                      '${it.quantity.getOrNull * it.price.getOrNull}'.asCurrency(),
                                                      // 'N 1230039',
                                                      maxLines: 1,
                                                      minFontSize: 14,
                                                      maxFontSize: 17,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w600,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //
                                              0.02.verticalh,
                                            ],
                                          ),
                                        )
                                        .asList(),
                                    //
                                    0.02.verticalh,
                                    //
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: AppButton(
                                            text: 'Pay Now',
                                            height: 0.05.h,
                                            isLoading: s.isLoading,
                                            disabled: s.isLoading,
                                            onPressed: c.read<RequestCubit>().pay,
                                          ),
                                        ),
                                        //
                                        0.04.horizontalw,
                                        //
                                        Flexible(
                                          child: AppButton(
                                            text: 'Cancel Order',
                                            height: 0.05.h,
                                            isLoading: s.isCancelling,
                                            disabled: s.isLoading || s.isCancelling,
                                            backgroundColor: const Color(0xFFE9EEF3),
                                            splashColor: Colors.black12,
                                            textColor: Palette.text100,
                                            textColorDark: Palette.text100,
                                            fontWeight: FontWeight.w600,
                                            onPressed: c.read<RequestCubit>().cancel,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          orElse: () => Utils.nothing,
                        ),
                        //
                        0.02.verticalh,
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final double max, dashWidth, space, dashHeight;

  final Color Function(int)? dashColor;

  const DotWidget({
    this.max = double.infinity,
    this.dashWidth = 10,
    this.space = 5,
    this.dashHeight = 2,
    this.dashColor,
  });

  double get _max => max == double.infinity ? 1.w : max;

  int get length => _max ~/ (dashWidth + space);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        length,
        (i) => Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == 0 ? 0 : space / 2,
              right: i == length - 1 ? 0 : space / 2,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(color: dashColor?.call(i)),
              child: SizedBox(
                width: i == length - 1 ? _max - (length - 1) * (dashWidth + space) : dashWidth,
                height: dashHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
