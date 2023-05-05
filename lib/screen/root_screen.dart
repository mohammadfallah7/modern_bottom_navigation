import 'package:bottom_navigation/logic/bottom_nav_provider.dart';
import 'package:bottom_navigation/screen/category_screen.dart';
import 'package:bottom_navigation/screen/home_screen.dart';
import 'package:bottom_navigation/screen/search_screen.dart';
import 'package:bottom_navigation/widget/my_navigator.dart';
import 'package:bottom_navigation/widget/on_will_pop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final GlobalKey<NavigatorState> homeKey = GlobalKey();
  final GlobalKey<NavigatorState> searchKey = GlobalKey();
  final GlobalKey<NavigatorState> categoryKey = GlobalKey();

  late final Map<int, GlobalKey<NavigatorState>> mapIndexToKey = {
    0: homeKey,
    1: searchKey,
    2: categoryKey,
  };

  List<int> history = [];

  @override
  void initState() {
    history.add(0);
    super.initState();
  }

  @override
  void dispose() {
    homeKey.currentState!.dispose();
    searchKey.currentState!.dispose();
    categoryKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData useTheme = Theme.of(context);

    return Consumer<BottomNavProvider>(
      builder: (context, bottomNavProvider, child) => WillPopScope(
        onWillPop: () => onWillPop(
          context,
          bottomNavProvider,
          mapIndexToKey,
          history,
        ),
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: useTheme.scaffoldBackgroundColor,
              systemNavigationBarColor: useTheme.scaffoldBackgroundColor,
              systemNavigationBarDividerColor: useTheme.scaffoldBackgroundColor,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: IndexedStack(
              index: bottomNavProvider.selectedScreenIndex,
              children: <Widget>[
                MyNavigator(
                  screen: const HomeScreen(),
                  screenKey: homeKey,
                ),
                MyNavigator(
                  screen: const SearchScreen(),
                  screenKey: searchKey,
                ),
                MyNavigator(
                  screen: const CategoryScreen(),
                  screenKey: categoryKey,
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavProvider.selectedScreenIndex,
            onTap: (index) {
              bottomNavProvider.toggleScreenIndex(index);

              history.remove(index);
              history.add(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Category',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
