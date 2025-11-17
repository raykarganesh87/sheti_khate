class Equipment {
  final int? id;
  final String name;
  final DateTime purchaseDate;
  final double price;
  final String description;
  final DateTime? lastMaintenance;

  Equipment({
    this.id,
    required this.name,
    required this.purchaseDate,
    required this.price,
    this.description = '',
    this.lastMaintenance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'purchase_date': purchaseDate.millisecondsSinceEpoch,
      'price': price,
      'description': description,
      'last_maintenance': lastMaintenance?.millisecondsSinceEpoch,
    };
  }

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      id: map['id'],
      name: map['name'],
      purchaseDate: DateTime.fromMillisecondsSinceEpoch(map['purchase_date']),
      price: map['price'],
      description: map['description'],
      lastMaintenance: map['last_maintenance'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_maintenance'])
          : null,
    );
  }
}