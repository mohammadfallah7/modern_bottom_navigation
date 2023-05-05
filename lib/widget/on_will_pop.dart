import 'package:bottom_navigation/logic/bottom_nav_provider.dart';
import 'package:bottom_navigation/widget/exit_popup.dart';
import 'package:flutter/material.dart';

Future<bool> onWillPop(
  BuildContext context,
  BottomNavProvider bottomNavProvider,
  Map<int, GlobalKey<NavigatorState>> mapIndexToKey,
  List<int> history,
) async {
  NavigatorState navigatorState =
      mapIndexToKey[bottomNavProvider.selectedScreenIndex]!.currentState!;

  if (navigatorState.canPop()) {
    navigatorState.pop();
  } else if (history.length > 1) {
    history.removeLast();

    bottomNavProvider.toggleScreenIndex(history.last);
  } else {
    return exitPopup(context);
  }

  return false;
}
