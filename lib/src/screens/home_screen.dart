// AI-ASSISTED: Modified by assistant on 2026-01-19
import 'package:flutter/material.dart';
import '../providers/grocery_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color mint = Color(0xFFD6F0EA);
  

  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final app = AppStateProvider.of(context);
    final items = app.items.where((it) {
      if (_filter.isEmpty) return true;
      final f = _filter.toLowerCase();
      return it.name.toLowerCase().contains(f) || it.category.toLowerCase().contains(f);
    }).toList();

    return Scaffold(
      backgroundColor: mint,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text('List\nShopping', style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800)),
                  ),
                  IconButton(
                    icon: Icon(app.isDark ? Icons.wb_sunny : Icons.dark_mode),
                    onPressed: () => app.toggleDark(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(hintText: 'Search', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none)),
                onChanged: (v) => setState(() => _filter = v),
              ),
              const SizedBox(height: 16),
              if (items.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: Text('You have nothing to\nbuy yet', style: TextStyle(fontSize: 18)),
                )
              else
                Expanded(
                  child: ReorderableListView.builder(
                    itemCount: items.length,
                    onReorder: (oldIndex, newIndex) {
                      // map visible indices back to app._items indices
                      final originalOld = app.items.indexOf(items[oldIndex]);
                      // when dragging to the end, newIndex equals items.length
                      final mappedNewIndex = newIndex >= items.length ? app.items.length : app.items.indexOf(items[newIndex]);
                      app.reorder(originalOld, mappedNewIndex);
                    },
                    buildDefaultDragHandles: true,
                    itemBuilder: (ctx, index) {
                      final item = items[index];
                      return Dismissible(
                        key: ValueKey('grocery-${item.id}'),
                        background: Container(
                          color: Colors.green,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            // edit
                            Navigator.pushNamed(context, '/add', arguments: item);
                          } else {
                            // delete
                            app.removeById(item.id);
                          }
                        },
                        child: ListTile(
                          key: ValueKey('tile-${item.id}'),
                          leading: Checkbox(
                            value: item.purchased,
                            onChanged: (_) => app.togglePurchased(item.id),
                          ),
                          title: Text(item.name),
                          subtitle: Text('x${item.quantity} • ${item.category}'),
                          trailing: ReorderableDragStartListener(
                            index: index,
                            child: const Icon(Icons.drag_handle),
                          ),
                          onTap: () => Navigator.pushNamed(context, '/details', arguments: item.id),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: SafeArea(child: SizedBox(height: 64, child: _BottomNavHost())),
      ),
    );
  }
}

// Small wrapper to avoid circular import issues; uses local Navigator calls
class _BottomNavHost extends StatelessWidget {
  const _BottomNavHost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(onTap: () => Navigator.pushNamed(context, '/home'), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.home), SizedBox(height: 4), Text('Home', style: TextStyle(fontSize: 12))])),
        InkWell(onTap: () => Navigator.pushNamed(context, '/add'), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.edit), SizedBox(height: 4), Text('Add', style: TextStyle(fontSize: 12))])),
        InkWell(onTap: () => Navigator.pushNamed(context, '/details'), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.list_alt), SizedBox(height: 4), Text('Details', style: TextStyle(fontSize: 12))])),
      ],
    );
  }
}
