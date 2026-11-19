import 'package:bloc_test/bloc_test.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';

void main() {
  blocTest<BottomNavCubit, BottomNavState>(
    'uses reorder-to-front history when tabs change',
    build: BottomNavCubit.new,
    act: (BottomNavCubit cubit) {
      cubit
        ..selectTab(1, tabCount: 3)
        ..selectTab(2, tabCount: 3)
        ..selectTab(1, tabCount: 3);
    },
    expect: () => <BottomNavState>[
      const BottomNavState(selectedIndex: 1, history: <int>[0, 1]),
      const BottomNavState(selectedIndex: 2, history: <int>[0, 1, 2]),
      const BottomNavState(selectedIndex: 1, history: <int>[0, 2, 1]),
    ],
  );

  blocTest<BottomNavCubit, BottomNavState>(
    'returns to the previous tab from history',
    build: BottomNavCubit.new,
    seed: () => const BottomNavState(selectedIndex: 2, history: <int>[0, 1, 2]),
    act: (BottomNavCubit cubit) => cubit.selectPreviousTab(),
    expect: () => <BottomNavState>[
      const BottomNavState(selectedIndex: 1, history: <int>[0, 1]),
    ],
  );

  blocTest<BottomNavCubit, BottomNavState>(
    'emits a reselection signal when the active tab is selected',
    build: BottomNavCubit.new,
    act: (BottomNavCubit cubit) => cubit.selectTab(0, tabCount: 3),
    expect: () => <BottomNavState>[const BottomNavState(reselectionSerial: 1)],
  );
}
