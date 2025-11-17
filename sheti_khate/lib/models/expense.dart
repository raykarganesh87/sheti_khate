class Expense {
  final int? id;
  final String name;
  final DateTime date;
  final double amount;
  final String category;
  final String description;

  Expense({
    this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.category,
    this.description = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
      'category': category,
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      amount: map['amount'],
      category: map['category'],
      description: map['description'] ?? '',
    );
  }
}
