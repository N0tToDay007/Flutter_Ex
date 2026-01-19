// AI-ASSISTED: Modified by assistant on 2026-01-19
import 'package:flutter/material.dart';
import '../providers/grocery_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  static const Color mint = Color(0xFFD6F0EA);
  static const Color bottomBar = Color(0xFF67B0A8);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final id = args is String ? args : null;
  final model = AppStateProvider.of(context);

    final item = id == null ? null : model.getById(id);

    return Scaffold(
      backgroundColor: mint,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Details', style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800)),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: item == null
                      ? const SizedBox.shrink()
                      : Dismissible(
                          key: ValueKey('details-${item.id}'),
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
                              Navigator.pushReplacementNamed(context, '/add', arguments: item);
                            } else {
                              // delete
                              model.removeById(item.id);
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 12),
                                Text('จำนวน: ${item.quantity}'),
                                const SizedBox(height: 8),
                                Text('หมวดหมู่: ${item.category}'),
                                const SizedBox(height: 12),
                                Text('หมายเหตุ:'),
                                Text(item.note.isEmpty ? '-' : item.note),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: SafeArea(child: SizedBox(height: 64, child: _DetailsBottomHost())),
      ),
    );
  }
}

class _DetailsBottomHost extends StatelessWidget {
  const _DetailsBottomHost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
  InkWell(onTap: () => Navigator.pushReplacementNamed(context, '/home'), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.home), SizedBox(height: 4), Text('Home', style: TextStyle(fontSize: 12))])),
  InkWell(onTap: () => Navigator.pushReplacementNamed(context, '/add'), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.edit), SizedBox(height: 4), Text('Add', style: TextStyle(fontSize: 12))])),
  InkWell(onTap: () => Navigator.pushReplacementNamed(context, '/details'), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.list_alt), SizedBox(height: 4), Text('Details', style: TextStyle(fontSize: 12))])),
      ],
    );
  }
}
