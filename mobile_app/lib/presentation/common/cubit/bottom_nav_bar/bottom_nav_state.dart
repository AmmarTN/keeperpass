part of 'bottom_nav_cubit.dart';

@freezed
abstract class BottomNavState with _$BottomNavState {
  const factory BottomNavState({
    @Default(0) int selectedIndex,
    @Default(<int>[0]) List<int> history,
    @Default(0) int reselectionSerial,

    /// Asks the shell to show [rootTab] at its first screen; bumped by
    /// [BottomNavCubit.openTabRoot].
    @Default(0) int rootSerial,
    @Default(0) int rootTab,

    /// Selection mode swaps the tab bar for its counted actions (board C4
    /// "Selection").
    @Default(false) bool barHidden,
  }) = _BottomNavState;
}
