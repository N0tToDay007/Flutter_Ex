// AI-ASSISTED: Modified by assistant on 2026-01-19
import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../providers/grocery_provider.dart';
import '../widgets/animated_scale_button.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _qtyCtl = TextEditingController(text: '1');
  String? _category;
  final _noteCtl = TextEditingController();

  GroceryItem? _editing;

  // Updated categories per requirement
  final List<String> _categories = ['ผัก', 'ผลไม้', 'ข้าวสาร', 'เนื้อหมู/ไก่'];

  static const Color mint = Color(0xFFD6F0EA);
  

  @override
  void dispose() {
    _nameCtl.dispose();
    _qtyCtl.dispose();
    _noteCtl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final app = AppStateProvider.of(context);
    final name = _nameCtl.text.trim();
    final qty = int.tryParse(_qtyCtl.text.trim()) ?? 1;
    final category = _category!.trim();
    final note = _noteCtl.text.trim();

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    if (_editing != null) {
      final updated = _editing!.copyWith(name: name, quantity: qty, category: category, note: note);
      app.updateItem(updated);
      app.setEditingItem(null);
      app.setViewingItem(updated.id);
      app.goToTab(2);
      return;
    }

    final item = GroceryItem(id: id, name: name, quantity: qty, category: category, note: note);
    app.addItem(item);
    // After adding, switch to Details tab and show the newly created item
    app.setViewingItem(id);
    app.goToTab(2);
  }

  Widget _cardField({required Widget child}) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Align(alignment: Alignment.centerLeft, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check AppState for editing request and prefill if present
    final app = AppStateProvider.of(context);
    final editId = app.editingItemId;
    if (editId != null && _editing == null) {
      final maybe = app.getById(editId);
      if (maybe != null) {
        _editing = maybe;
        _nameCtl.text = _editing!.name;
        _qtyCtl.text = _editing!.quantity.toString();
        _category = _editing!.category;
        _noteCtl.text = _editing!.note;
      }
    }
    return Scaffold(
      backgroundColor: mint,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('List\nShopping', style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800)),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Expanded(
                  child: ListView(
                    children: [
                      _cardField(
                        child: TextFormField(
                          controller: _nameCtl,
                          decoration: const InputDecoration(border: InputBorder.none, hintText: 'ชื่อสินค้า'),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณากรอกชื่อสินค้า' : null,
                        ),
                      ),
                      _cardField(
                        child: TextFormField(
                          controller: _qtyCtl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(border: InputBorder.none, hintText: 'จำนวน'),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'กรุณากรอกจำนวน';
                            final n = int.tryParse(v);
                            if (n == null || n <= 0) return 'จำนวนต้องเป็นจำนวนเต็มมากกว่า 0';
                            return null;
                          },
                        ),
                      ),
                      _cardField(
                        child: DropdownButtonFormField<String>(
                          value: _category,
                          decoration: const InputDecoration(border: InputBorder.none, hintText: 'หมวดหมู่'),
                          items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                          onChanged: (v) => setState(() => _category = v),
                          validator: (v) => (v == null || v.isEmpty) ? 'เลือกหมวดหมู่' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedScaleButton(
                        onTap: _submit,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                          child: const Center(child: Text('บันทึก', style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

