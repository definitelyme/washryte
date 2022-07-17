library order_history_screen.dart;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:date_format/date_format.dart';

/// A stateless widget to render OrderHistoryScreen.
class OrderHistoryScreen extends StatelessWidget with AutoRouteWrapper {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
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
        child: this,
      ),
    );
  }

  void onLoadMore(BuildContext c, DragToRefreshState state) async {
    final cubit = c.read<RequestCubit>();

    if (!cubit.state.isLoading) {
      await cubit.history(nextPage: true);
      state.loadComplete();
    } else
      state.loadComplete();
  }

  void onRefresh(BuildContext c, DragToRefreshState state) async {
    final cubit = c.read<RequestCubit>();

    if (!cubit.state.isLoading) {
      await cubit.history(perPage: 10);
      state.refreshCompleted(resetFooterState: true);
    } else
      state.refreshCompleted(resetFooterState: true);
  }

  void _pickDate(BuildContext ctx, DateTime? date) async {
    final cubit = ctx.read<RequestCubit>();

    DateTime? chosenDate;

    await App.showAdaptiveDatePicker(
      ctx,
      selectedDate: date,
      firstDate: ServiceRequest.firstDate,
      lastDate: ServiceRequest.lastDate,
      initialDatePickerMode: DatePickerMode.day,
      confirmText: 'Done',
      cancelText: 'Cancel',
      errorInvalidText: 'Invalid date',
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          primaryColor: Palette.accent20,
          primaryColorDark: Palette.accent20,
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: Utils.foldTheme(
            context: ctx,
            light: () => const ColorScheme.light(
              primary: Palette.accentColor,
              secondary: Palette.accent20,
              onPrimary: Colors.white,
            ),
            dark: () => ColorScheme.dark(
              primary: Palette.accentColor,
              secondary: Palette.accent20,
              onPrimary: Colors.white,
              onSurface: Colors.white,
              surface: Palette.accentColor.shade800,
            ),
          ),
        ),
        child: child!,
      ),
      onChanged: (d) => chosenDate = d,
    );

    if (cubit.state.selectedDate != chosenDate) cubit.dateChanged(chosenDate);
  }

  @override
  Widget build(BuildContext context) {
    return AppSliverScrollView.scaffold(
      title: 'Order History',
      implyMiddle: false,
      isPaginated: true,
      enablePullUp: true,
      initialRefresh: true,
      showCustomLeading: false,
      autoImplyLeading: false,
      onRefresh: (s) => onRefresh(context, s),
      onLoading: (s) => onLoadMore(context, s),
      actions: [
        BlocSelector<RequestCubit, RequestState, bool>(
          selector: (s) => s.isFetchingByDate,
          builder: (c, isLoading) => AnimatedVisibility(
            visible: isLoading,
            child: Padding(
              padding: EdgeInsets.only(right: App.sidePadding),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: CircularProgressBar.adaptive(strokeWidth: 2, height: 30, width: 30),
                ),
              ),
            ),
          ),
        ),
      ],
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: App.sidePadding),
          sliver: SliverToBoxAdapter(
            child: BlocBuilder<RequestCubit, RequestState>(
              builder: (c, s) => Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: AdaptiveText(
                      s.selectedDate == null
                          ? 'All time order'
                          : DateTimeUtils.dayOfMonth(
                              s.selectedDate!,
                              // (suffixed) => 'EEEE MMMM $suffixed, yyyy',
                            ),
                      maxLines: 1,
                      fontSize: 17.sp,
                      textColor: Palette.accentColor,
                      fontWeight: s.selectedDate == null ? FontWeight.w400 : FontWeight.w600,
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
                      onTap: s.isFetchingByDate ? null : () => _pickDate(c, s.selectedDate),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Utils.platform_(material: Icons.calendar_today, cupertino: CupertinoIcons.calendar),
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
        ),
        //
        SliverToBoxAdapter(child: 0.02.verticalh),
        //
        BlocBuilder<RequestCubit, RequestState>(
          builder: (c, s) => SliverFixedExtentList(
            itemExtent: 0.09.h,
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                final it = s.history.getOrNull(i);
                return AdaptiveListTile(
                  material: true,
                  shape: RoundedRectangleBorder(borderRadius: 8.br),
                  contentPadding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                  horizontalTitleGap: 6,
                  leading: const Icon(Icons.history),
                  title: AdaptiveText(
                    '${it?.items.getOrEmpty}',
                    maxLines: 1,
                    minFontSize: 16,
                    fontSize: 17.sp,
                    softWrap: false,
                    fontWeight: FontWeight.w600,
                    letterSpacing: Utils.letterSpacing,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: it?.createdAt == null
                      ? null
                      : AdaptiveText(
                          '${formatDate(it!.createdAt!, [dd, ', ', M, ' ', yyyy])}',
                          maxLines: 1,
                          minFontSize: 14,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: Utils.letterSpacing,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                  trailing: Material(
                    borderRadius: 7.br,
                    color: const Color(0xffE7F1F5),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                  onTap: it != null ? () => navigator.navigate(TrackingRoute(request: it)) : null,
                );
              },
              childCount: s.history.size,
            ),
          ),
        ),
      ],
    );
  }
}
