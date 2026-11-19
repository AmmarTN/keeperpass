import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_tab_bar.dart';
import 'package:keeperpass/presentation/features/bottom_nav_layout/models/bottom_nav_destination.dart';

/// Preserves each tab with an independent nested navigator.
///
/// Selecting the current tab pops its nested navigator to the first route.
/// System back first pops the active nested navigator, then follows tab history.
class BottomNavigationShell extends StatefulWidget {
  const BottomNavigationShell({required this.destinations, super.key})
    : assert(destinations.length >= 2);

  final List<BottomNavDestination> destinations;

  @override
  State<BottomNavigationShell> createState() => _BottomNavigationShellState();
}

class _BottomNavigationShellState extends State<BottomNavigationShell> {
  late List<GlobalKey<NavigatorState>> _navigatorKeys;
  late List<Widget?> _tabNavigators;
  AppToastHostState? _toasts;

  @override
  void initState() {
    super.initState();
    _initializeTabs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Toasts sit just above the tab bar (`.btoast`: 96 pt from the bottom).
    _toasts = AppToastHost.maybeOf(context);
    _toasts?.bottomOffset.value = AppTabBar.reachAboveInset(context);
  }

  @override
  void dispose() {
    _toasts?.bottomOffset.value = 0;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BottomNavigationShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.destinations.length != widget.destinations.length) {
      _initializeTabs();
      context.read<BottomNavCubit>().reset();
    }
  }

  void _initializeTabs() {
    _navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      widget.destinations.length,
      (_) => GlobalKey<NavigatorState>(),
    );
    _tabNavigators = List<Widget?>.filled(widget.destinations.length, null);
  }

  Widget _tabNavigator(int index) {
    return _tabNavigators[index] ??= Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (_) =>
          MaterialPageRoute<void>(builder: widget.destinations[index].builder),
    );
  }

  Future<void> _handleBack(BottomNavCubit cubit, int selectedIndex) async {
    final NavigatorState? tabNavigator =
        _navigatorKeys[selectedIndex].currentState;
    if (await (tabNavigator?.maybePop() ?? Future<bool>.value(false))) return;
    cubit.selectPreviousTab();
  }

  void _selectTab(BottomNavCubit cubit, int index) {
    if (index == cubit.state.selectedIndex) {
      _navigatorKeys[index].currentState?.popUntil((Route<dynamic> route) {
        return route.isFirst;
      });
    }
    cubit.selectTab(index, tabCount: widget.destinations.length);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavCubit, BottomNavState>(
      listenWhen: (BottomNavState a, BottomNavState b) =>
          a.rootSerial != b.rootSerial,
      listener: (BuildContext context, BottomNavState state) =>
          _navigatorKeys[state.rootTab].currentState?.popUntil(
            (Route<dynamic> route) => route.isFirst,
          ),
      child: _shell(context),
    );
  }

  Widget _shell(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (BuildContext context, BottomNavState state) {
        final int selectedIndex = state.selectedIndex;
        _tabNavigator(selectedIndex);

        return PopScope<Object?>(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) return;
            await _handleBack(context.read<BottomNavCubit>(), selectedIndex);
          },
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: IndexedStack(
              index: selectedIndex,
              children: _tabNavigators
                  .map((Widget? page) => page ?? const SizedBox.shrink())
                  .toList(growable: false),
            ),
            bottomNavigationBar: state.barHidden
                ? null
                : AppTabBar(
                    tabs: <AppTab>[
                      for (final BottomNavDestination destination
                          in widget.destinations)
                        AppTab(
                          icon: destination.icon,
                          label: destination.label,
                          badgeCount: destination.badgeCount,
                          semanticLabel: destination.semanticLabel,
                        ),
                    ],
                    selectedIndex: selectedIndex,
                    onSelected: (int index) {
                      _selectTab(context.read<BottomNavCubit>(), index);
                    },
                  ),
          ),
        );
      },
    );
  }
}
