library insight_page.dart;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/features/dashboard/domain/domain.dart';
import 'package:washryte/features/dashboard/presentation/managers/index.dart';
import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

/// A stateless widget to render InsightPage.
class InsightPage extends StatefulWidget {
  const InsightPage({Key? key}) : super(key: key);

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  late RequestCubit cubit;

  @override
  void initState() {
    cubit = getIt<RequestCubit>();
    super.initState();
  }

  void onLoadMore(DragToRefreshState state) async {
    await cubit.active(nextPage: true);
    state.loadComplete();
  }

  void onRefresh(DragToRefreshState state) async {
    await cubit.active(perPage: 10);
    state.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
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
        child: AppSliverScrollView.scaffold(
          title: 'Track Order',
          initialRefresh: true,
          enablePullUp: true,
          isPaginated: true,
          implyMiddle: false,
          showCustomLeading: false,
          autoImplyLeading: false,
          onLoading: onLoadMore,
          onRefresh: onRefresh,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: App.sidePadding).copyWith(top: 0.01.h),
              sliver: BlocBuilder<RequestCubit, RequestState>(
                builder: (c, s) {
                  if (s.activeRequests.isEmpty()) return const SliverToBoxAdapter(child: Utils.nothing);

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) {
                        final req = s.activeRequests.get(i);

                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AdaptiveListTile(
                                material: true,
                                dense: true,
                                shape: RoundedRectangleBorder(borderRadius: 8.br),
                                leading: AppAssets.dashboardTimeline(Size.square(0.08.w)),
                                tileColor: App.resolveColor(const Color(0xFFE7F1F5), dark: Palette.cardColorDark),
                                horizontalTitleGap: 8,
                                title: Padding(
                                  padding: EdgeInsets.only(bottom: 0.008.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      0.007.verticalh,
                                      //
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AdaptiveText(
                                            '${timeago.format(req.createdAt!)}',
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          //
                                          0.006.verticalh,
                                          //
                                          AdaptiveText(
                                            '${req.status.name}',
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: Utils.letterSpacing,
                                          ),
                                        ],
                                      ),
                                      //
                                      ...req.status.maybeWhen(
                                        delivered: () => [Utils.nothing],
                                        cancelled: () => [Utils.nothing],
                                        orElse: () => [
                                          0.01.verticalh,
                                          //
                                          AdaptiveText(
                                            'In progress',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            style: const TextStyle(fontStyle: FontStyle.italic),
                                            letterSpacing: Utils.letterSpacing,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: req.status.maybeWhen(
                                  delivered: () => Utils.nothing,
                                  cancelled: () => Utils.nothing,
                                  orElse: () => AdaptiveText(
                                    'Track',
                                    fontSize: 16.sp,
                                    textColor: Palette.accentColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: Utils.letterSpacing,
                                  ),
                                ),
                                onTap: () => navigator.navigate(TrackingRoute(request: req)),
                              ),
                              //
                              0.013.verticalh,
                            ],
                          ),
                        );
                      },
                      childCount: s.activeRequests.size,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
