// AI-ASSISTED: Modified by assistant on 2026-01-19
import 'package:flutter/widgets.dart';
import '../models/grocery_item.dart';

/// AppState holds the list of grocery items and app-wide settings like dark mode.
class AppState extends ChangeNotifier {
  final List<GroceryItem> _items = [];
  bool _isDark = false;
  // Tab and selection helpers for IndexedStack-based navigation
  int _selectedTab = 0;
  String? _editingItemId;
  String? _viewingItemId;

  List<GroceryItem> get items => List.unmodifiable(_items);
  bool get isDark => _isDark;
  int get selectedTab => _selectedTab;
  String? get editingItemId => _editingItemId;
  String? get viewingItemId => _viewingItemId;

  void toggleDark() {
    _isDark = !_isDark;
    notifyListeners();
  }

  // IndexedStack helpers
  void goToTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void setEditingItem(String? id) {
    _editingItemId = id;
    notifyListeners();
  }

  void setViewingItem(String? id) {
    _viewingItemId = id;
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeById(String id) {
    _items.removeWhere((it) => it.id == id);
    notifyListeners();
  }

  GroceryItem? getById(String id) {
    try {
      return _items.firstWhere((it) => it.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateItem(GroceryItem updated) {
    final idx = _items.indexWhere((it) => it.id == updated.id);
    if (idx != -1) {
      _items[idx] = updated;
      notifyListeners();
    }
  }

  void togglePurchased(String id) {
    final idx = _items.indexWhere((it) => it.id == id);
    if (idx != -1) {
      _items[idx].purchased = !_items[idx].purchased;
      notifyListeners();
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    notifyListeners();
  }
}

/// AppStateProvider exposes an [AppState] instance to the widget tree.
class AppStateProvider extends InheritedNotifier<AppState> {
  AppStateProvider({Key? key, required Widget child, AppState? notifier}) : super(key: key, notifier: notifier ?? AppState(), child: child);

  static AppState of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'No AppStateProvider found in context');
    return provider!.notifier!;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<AppState> oldWidget) => notifier != oldWidget.notifier;
}
