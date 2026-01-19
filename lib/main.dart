// AI-ASSISTED: Modified by assistant on 2026-01-19
import 'package:flutter/material.dart';

import 'src/providers/grocery_provider.dart';
import 'src/screens/main_tabs.dart';
import 'src/screens/add_item_screen.dart';
import 'src/screens/details_screen.dart';
import 'src/screens/onboarding_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock to portrait to give a phone-like presentation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const GroceryApp());
}

/// GroceryApp
/// A small Flutter app to manage an "outdoor shopping checklist" for homemakers.
///
/// File organization (categories):
/// - lib/src/models: data models (`grocery_item.dart`)
/// - lib/src/providers: app state provider (`grocery_provider.dart`)
/// - lib/src/screens: screens/widgets that represent full pages
/// - lib/src/widgets: smaller reusable widgets (kept simple, inlined where small)
///
/// Main features implemented:
/// - At least 3 screens using Navigator: Home, Add Item, Details
/// - Dismissible items to delete by swipe
/// - Add Item form with validation (name, quantity, category)
/// - ReorderableListView to reorder the shopping list

class GroceryApp extends StatelessWidget {
  // ignore: use_super_parameters
  const GroceryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create app state here so we can bind themeMode
    final appState = AppState();
    return AppStateProvider(
      notifier: appState,
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'แม่บ้าน Shopping Checklist',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
              useMaterial3: true,
            ),
            // ignore: deprecated_member_use
            darkTheme: ThemeData.dark().copyWith(useMaterial3: true),
            themeMode: appState.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const OnboardingScreen(),
              routes: {
                // Home is available at '/home' so bottom navigation and other
                // places can navigate to the main list screen.
                '/home': (ctx) => const MainTabs(),
                '/add': (ctx) => const AddItemScreen(),
                '/details': (ctx) => const DetailsScreen(),
              },
          );
        },
      ),
    );
  }
}

