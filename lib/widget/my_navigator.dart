import 'package:flutter/material.dart';

class MyNavigator extends StatelessWidget {
  const MyNavigator({super.key, required this.screen, required this.screenKey});

  final Widget screen;
  final GlobalKey<NavigatorState> screenKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: screenKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
