import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'bottom_nav_cubit.freezed.dart';
part 'bottom_nav_state.dart';

@injectable
final class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState());

  void selectTab(int index, {required int tabCount}) {
    RangeError.checkValidIndex(index, List<void>.filled(tabCount, null));

    if (index == state.selectedIndex) {
      reselectCurrentTab();
      return;
    }

    final List<int> history = <int>[
      ...state.history.where((int item) => item != index),
      index,
    ];
    emit(state.copyWith(selectedIndex: index, history: history));
  }

  /// Another tab's screen sends the person to [index] at its first screen
  /// (the Security report's "Show all" opens the Vault list).
  void openTabRoot(int index, {required int tabCount}) {
    selectTab(index, tabCount: tabCount);
    emit(state.copyWith(rootTab: index, rootSerial: state.rootSerial + 1));
  }

  void reselectCurrentTab() {
    emit(state.copyWith(reselectionSerial: state.reselectionSerial + 1));
  }

  /// Selects the previous tab in the reorder-to-front history.
  /// Returns false when the first tab is already the only history entry.
  bool selectPreviousTab() {
    if (state.history.length <= 1) return false;

    final List<int> history = List<int>.of(state.history)..removeLast();
    emit(state.copyWith(selectedIndex: history.last, history: history));
    return true;
  }

  void setBarHidden(bool hidden) {
    if (state.barHidden == hidden) return;
    emit(state.copyWith(barHidden: hidden));
  }

  void reset() {
    if (state == const BottomNavState()) return;
    emit(const BottomNavState());
  }
}
