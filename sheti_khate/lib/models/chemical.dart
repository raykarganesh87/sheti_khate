class Chemical {
  final int? id;
  final String name;
  final String type; // fertilizer, insecticide, herbicide
  final DateTime usageDate;
  final double quantity;
  final String cropName;
  final double areaCovered;
  final String description;

  Chemical({
    this.id,
    required this.name,
    required this.type,
    required this.usageDate,
    required this.quantity,
    required this.cropName,
    required this.areaCovered,
    this.description = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'usage_date': usageDate.millisecondsSinceEpoch,
      'quantity': quantity,
      'crop_name': cropName,
      'area_covered': areaCovered,
      'description': description,
    };
  }

  factory Chemical.fromMap(Map<String, dynamic> map) {
    return Chemical(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      usageDate: DateTime.fromMillisecondsSinceEpoch(map['usage_date']),
      quantity: map['quantity'],
      cropName: map['crop_name'],
      areaCovered: map['area_covered'],
      description: map['description'],
    );
  }
}