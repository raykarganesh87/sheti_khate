import 'package:flutter/material.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';
import 'package:sheti_khate/models/equipment.dart';
import 'package:sheti_khate/services/database_service.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Equipment> _equipment = [];

  @override
  void initState() {
    super.initState();
    _loadEquipment();
  }

  Future<void> _loadEquipment() async {
    final equipment = await _dbService.getEquipment();
    setState(() {
      _equipment = equipment;
    });
  }

  Future<void> _showAddEquipmentDialog() async {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    String name = '';
    DateTime purchaseDate = DateTime.now();
    double price = 0.0;
    String description = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.translate('add_equipment')!),
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
                labelText: localizations.translate('price'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => price = double.tryParse(value) ?? 0.0,
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
              final equipment = Equipment(
                name: name,
                purchaseDate: purchaseDate,
                price: price,
                description: description,
              );
              await _dbService.insertEquipment(equipment);
              _loadEquipment();
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
        onPressed: _showAddEquipmentDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: _equipment.isEmpty
          ? Center(
              child: Text(
                'कोणतीही उपकरणे नोंद नाही',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: _equipment.length,
              itemBuilder: (context, index) {
                final item = _equipment[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${localizations.translate('price')}: ₹${item.price.toStringAsFixed(2)}'),
                        Text('${localizations.translate('purchase_date')}: ${_formatDate(item.purchaseDate)}'),
                      ],
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