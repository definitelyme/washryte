library notification_page.dart;

import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/core/presentation/index.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/features/dashboard/presentation/widgets/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

/// A stateless widget to render NotificationPage.
class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  Future<void> onLoadMore(BuildContext c, DragToRefreshState refresh) async {
    final cubit = c.read<RequestCubit>();

    if (!cubit.state.isLoading) {
      await cubit.inAppNotifications(nextPage: true);
      refresh.loadComplete();
    } else
      refresh.loadComplete();

    Future.delayed(const Duration(seconds: 30), () {
      if (refresh.controller.isLoading) refresh.loadComplete();
    });
  }

  Future<void> onRefresh(BuildContext c, DragToRefreshState refresh) async {
    final cubit = c.read<RequestCubit>();

    if (!cubit.state.isLoading) {
      await cubit.inAppNotifications(perPage: 10);
      refresh.refreshCompleted(resetFooterState: true);
    } else
      refresh.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RequestCubit>(),
      child: BlocListener<RequestCubit, RequestState>(
        listenWhen: (p, c) =>
            p.status.getOrElse(() => null) != c.status.getOrElse(() => null) ||
            (c.status.getOrElse(() => null) != null && (c.status.getOrElse(() => null)!.response.maybeMap(orElse: () => false))),
        listener: (c, s) => s.status.fold(
          () => null,
          (it) => it?.response.map(
            info: (i) => PopupDialog.info(message: i.message, show: i.message.isNotEmpty).render(c),
            error: (f) => PopupDialog.error(message: f.message, show: f.show && f.message.isNotEmpty).render(c),
            success: (s) => PopupDialog.success(message: s.message, show: s.message.isNotEmpty).render(c),
          ),
        ),
        child: BlocBuilder<RequestCubit, RequestState>(
          builder: (c, s) => AppSliverScrollView.scaffold(
            title: 'Notifications',
            isPaginated: true,
            enablePullUp: true,
            initialRefresh: true,
            implyMiddle: false,
            showCustomLeading: false,
            autoImplyLeading: false,
            onRefresh: (refresh) => onRefresh(c, refresh),
            onLoading: (refresh) => onLoadMore(c, refresh),
            slivers: [
              SliverToBoxAdapter(
                child: AnimatedVisibility(
                  visible: (!s.isLoading && s.notificationList.isEmpty()) || s.notificationList.isEmpty(),
                  child: EmptyStateWidget(
                    useScaffold: false,
                    height: 0.8.h,
                    width: 1.w,
                    asset: right(AppAssets.balloons),
                    title: 'You’re all caught up!',
                  ),
                ),
              ),
              //
              if (!s.isLoading && s.notificationList.isNotEmpty())
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    ...s.notifications
                        .map(
                          (entry) => GroupedLayoutCard(
                            dateTime: entry.key,
                            count: entry.value.size,
                            verticalGap: 0.017.h,
                            layout: (i) => entry.value.get(i).meta!.maybeMap(
                                  orElse: () => _NotificationCard(entry.value.get(i)),
                                  order: (e) => _OrderNotificationCard(
                                    entry.value.get(i),
                                    model: e.request,
                                  ),
                                ),
                          ),
                        )
                        .iter,
                  ]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderNotificationCard extends StatelessWidget {
  final InAppNotification notification;
  final ServiceRequest? model;

  const _OrderNotificationCard(
    this.notification, {
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveListTile(
      dense: true,
      noCupertinoBorder: true,
      horizontalTitleGap: 0,
      tileColor: App.resolveColor(Palette.cardColorLight, dark: Palette.cardColorDark),
      borderRadius: 8.br,
      leading: Icon(
        model?.status.maybeWhen(
          pending: () => Icons.paste,
          done: () => Icons.shopping_basket_outlined,
          enroute: () => Icons.pedal_bike_rounded,
          cancelled: () => Icons.cancel,
          paid: () => Icons.monetization_on_outlined,
          orElse: () => Utils.platform_(material: Icons.notifications_active_outlined, cupertino: CupertinoIcons.bell),
        ),
        color: App.resolveColor(Palette.secondaryColor, dark: Palette.cardColorLight),
        size: 20,
      ),
      title: AdaptiveText(
        '${notification.title.getOrEmpty}',
        maxLines: 1,
        maxFontSize: 16,
        softWrap: false,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: AdaptiveText(
        '${notification.message.getOrEmpty}',
        maxFontSize: 15,
        softWrap: true,
        wrapWords: true,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.start,
      ),
      trailing: notification.createdAt == null
          ? null
          : AdaptiveText(
              '${timeago.format(notification.createdAt!)}',
              maxLines: 1,
              maxFontSize: 15,
              softWrap: false,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final InAppNotification notification;

  const _NotificationCard(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveListTile(
      dense: true,
      noCupertinoBorder: true,
      horizontalTitleGap: 0,
      tileColor: App.resolveColor(Palette.cardColorLight, dark: Palette.cardColorDark),
      borderRadius: 8.br,
      leading: Icon(
        Utils.platform_(material: Icons.notifications_active_outlined, cupertino: CupertinoIcons.bell),
        color: App.resolveColor(Palette.secondaryColor, dark: Palette.cardColorLight),
        size: 24,
      ),
      title: AdaptiveText(
        '${notification.title.getOrEmpty}',
        maxLines: 1,
        maxFontSize: 16,
        softWrap: false,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: AdaptiveText(
        '${notification.message.getOrEmpty}',
        maxFontSize: 15,
        softWrap: true,
        wrapWords: true,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.start,
      ),
      trailing: notification.createdAt == null
          ? null
          : AdaptiveText(
              '${timeago.format(notification.createdAt!)}',
              maxLines: 1,
              maxFontSize: 15,
              softWrap: false,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}
