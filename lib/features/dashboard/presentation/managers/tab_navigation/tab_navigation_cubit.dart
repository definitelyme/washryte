import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:washryte/features/dashboard/presentation/pages/index.dart';
import 'package:washryte/utils/utils.dart' as util;

part 'tab_navigation_cubit.freezed.dart';
part 'tab_navigation_state.dart';

@injectable
class TabNavigationCubit extends HydratedCubit<TabNavigationState> {
  static const String _kBottomTabKey = 'persisted-tab';
  // static const String _kSingleRestaurantTabKey = 'single-restaurant-tabbar-key';

  TabNavigationCubit() : super(TabNavigationState.initial());

  @override
  TabNavigationState? fromJson(Map<String, dynamic> json) {
    try {
      final _index = json[_kBottomTabKey] as int;
      return state.copyWith(currentIndex: _index);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TabNavigationState state) {
    if (state != TabNavigationState.initial())
      return <String, dynamic>{_kBottomTabKey: state.currentIndex};
    else
      return null;
  }

  void init() {
    emit(state.copyWith(isInit: false));
    state.tabRouter?.setActiveIndex(state.currentIndex);
  }

  void updateTabsRouter(TabsRouter? router) => emit(state.copyWith(tabRouter: router ?? state.tabRouter));

  void setCurrentIndex([TabsRouter? router, int index = 0]) {
    updateTabsRouter(router);

    emit(state.copyWith(currentIndex: index));
    state.tabRouter?.setActiveIndex(index);
  }
}
