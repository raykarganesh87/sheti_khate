import 'package:flutter/material.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';
import 'package:sheti_khate/models/expense.dart';
import 'package:sheti_khate/services/database_service.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final expenses = await _dbService.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  Future<void> _showAddExpenseDialog() async {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    String name = '';
    DateTime date = DateTime.now();
    double amount = 0.0;
    String category = 'इतर';
    String description = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.translate('add_expense')!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('name'),
              ),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('amount'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => amount = double.tryParse(value) ?? 0.0,
            ),
            DropdownButtonFormField<String>(
              value: category,
              decoration: InputDecoration(
                labelText: localizations.translate('category'),
              ),
              items: [
                'बियाणे',
                'खत',
                'कीटकनाशक',
                'कामगार',
                'पाणी',
                'इतर'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  category = newValue;
                }
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('description'),
              ),
              maxLines: 3,
              onChanged: (value) => description = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.translate('cancel')!),
          ),
          ElevatedButton(
            onPressed: () async {
              final expense = Expense(
                name: name,
                date: date,
                amount: amount,
                category: category,
                description: description,
              );
              await _dbService.insertExpense(expense);
              _loadExpenses();
              Navigator.pop(context);
            },
            child: Text(localizations.translate('save')!),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: _expenses.isEmpty
          ? Center(
              child: Text(
                'कोणताही खर्च नोंद नाही',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(expense.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${localizations.translate('category')}: ${expense.category}'),
                        Text('${localizations.translate('date')}: ${_formatDate(expense.date)}'),
                      ],
                    ),
                    trailing: Text(
                      '₹${expense.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}