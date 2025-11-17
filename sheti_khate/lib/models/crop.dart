class Crop {
  final int? id;
  final String name;
  final DateTime plantingDate;
  final DateTime? harvestDate;
  final double area;
  final String variety;
  final double expectedYield;
  final double actualYield;
  final String notes;

  Crop({
    this.id,
    required this.name,
    required this.plantingDate,
    this.harvestDate,
    required this.area,
    required this.variety,
    required this.expectedYield,
    this.actualYield = 0.0,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'planting_date': plantingDate.millisecondsSinceEpoch,
      'harvest_date': harvestDate?.millisecondsSinceEpoch,
      'area': area,
      'variety': variety,
      'expected_yield': expectedYield,
      'actual_yield': actualYield,
      'notes': notes,
    };
  }

  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop(
      id: map['id'],
      name: map['name'],
      plantingDate: DateTime.fromMillisecondsSinceEpoch(map['planting_date']),
      harvestDate: map['harvest_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['harvest_date'])
          : null,
      area: map['area'],
      variety: map['variety'],
      expectedYield: map['expected_yield'],
      actualYield: map['actual_yield'],
      notes: map['notes'],
    );
  }
}