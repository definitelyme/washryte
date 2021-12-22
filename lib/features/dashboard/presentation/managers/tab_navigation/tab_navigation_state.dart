part of 'tab_navigation_cubit.dart';

@freezed
@immutable
class TabNavigationState with _$TabNavigationState {
  const factory TabNavigationState({
    TabsRouter? tabRouter,
    @Default(0) int currentIndex,
    @Default(0) int selectedTab,
    @Default(0) int previousIndex,
    @Default(false) bool isLoading,
    @Default(true) bool isInit,
    required Set<Map<String, Widget>> tabs,
  }) = _TabNavigationState;

  factory TabNavigationState.initial() => const TabNavigationState(
        tabs: {
          {'${util.HomePage.name}': HomePage()},
          {'${util.InsightPage.name}': InsightPage()},
          {'${util.NotificationPage.name}': NotificationPage()},
          {'${util.ProfilePage.name}': ProfilePage()},
        },
      );
}
