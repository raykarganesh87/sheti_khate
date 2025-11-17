import 'package:flutter/material.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';
import 'package:sheti_khate/models/chemical.dart';
import 'package:sheti_khate/services/database_service.dart';

class ChemicalsScreen extends StatefulWidget {
  const ChemicalsScreen({Key? key}) : super(key: key);

  @override
  State<ChemicalsScreen> createState() => _ChemicalsScreenState();
}

class _ChemicalsScreenState extends State<ChemicalsScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Chemical> _chemicals = [];

  @override
  void initState() {
    super.initState();
    _loadChemicals();
  }

  Future<void> _loadChemicals() async {
    final chemicals = await _dbService.getChemicals();
    setState(() {
      _chemicals = chemicals;
    });
  }

  Future<void> _showAddChemicalDialog() async {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    String name = '';
    String type = 'खत';
    DateTime usageDate = DateTime.now();
    double quantity = 0.0;
    String cropName = '';
    double areaCovered = 0.0;
    String description = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.translate('add_chemical')!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('name'),
              ),
              onChanged: (value) => name = value,
            ),
            DropdownButtonFormField<String>(
              value: type,
              decoration: InputDecoration(
                labelText: localizations.translate('chemical_type'),
              ),
              items: [
                localizations.translate('fertilizer')!,
                localizations.translate('insecticide')!,
                localizations.translate('herbicide')!,
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  type = newValue;
                }
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('quantity'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => quantity = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('crop_name'),
              ),
              onChanged: (value) => cropName = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('area_covered'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => areaCovered = double.tryParse(value) ?? 0.0,
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
              final chemical = Chemical(
                name: name,
                type: type,
                usageDate: usageDate,
                quantity: quantity,
                cropName: cropName,
                areaCovered: areaCovered,
                description: description,
              );
              await _dbService.insertChemical(chemical);
              _loadChemicals();
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
        onPressed: _showAddChemicalDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: _chemicals.isEmpty
          ? Center(
              child: Text(
                'कोणतीही रसायने नोंद नाही',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: _chemicals.length,
              itemBuilder: (context, index) {
                final chemical = _chemicals[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(chemical.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${localizations.translate('chemical_type')}: ${chemical.type}'),
                        Text('${localizations.translate('crop_name')}: ${chemical.cropName}'),
                        Text('${localizations.translate('quantity')}: ${chemical.quantity} किलो'),
                      ],
                    ),
                    trailing: Text(
                      _formatDate(chemical.usageDate),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
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