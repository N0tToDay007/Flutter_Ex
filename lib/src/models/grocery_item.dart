class GroceryItem {
  final String id;
  final String name;
  final int quantity;
  final String category;
  final String note;
  bool purchased;
  final DateTime createdAt;

  GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    this.note = '',
    this.purchased = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  GroceryItem copyWith({
    String? id,
    String? name,
    int? quantity,
    String? category,
    String? note,
    bool? purchased,
  }) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      note: note ?? this.note,
      purchased: purchased ?? this.purchased,
      createdAt: createdAt,
    );
  }
}
