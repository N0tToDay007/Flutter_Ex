import 'package:flutter/material.dart';

import '../providers/grocery_provider.dart';
import '../screens/home_screen.dart';
import '../screens/add_item_screen.dart';
import '../screens/details_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({Key? key}) : super(key: key);

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  @override
  Widget build(BuildContext context) {
    final app = AppStateProvider.of(context);
    // Listen to app for tab changes
    return AnimatedBuilder(
      animation: app,
      builder: (context, _) {
        final current = app.selectedTab;
        return Scaffold(
          body: IndexedStack(
            index: current,
            children: const [
              HomeScreen(),
              AddItemScreen(),
              DetailsScreen(),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: BottomNavBar(
              currentIndex: current,
              onTap: (i) => app.goToTab(i),
            ),
          ),
        );
      },
    );
  }
}
