import 'package:flutter/material.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';
import 'package:sheti_khate/models/crop.dart';
import 'package:sheti_khate/services/database_service.dart';

class CropManagementScreen extends StatefulWidget {
  const CropManagementScreen({Key? key}) : super(key: key);

  @override
  State<CropManagementScreen> createState() => _CropManagementScreenState();
}

class _CropManagementScreenState extends State<CropManagementScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Crop> _crops = [];

  @override
  void initState() {
    super.initState();
    _loadCrops();
  }

  Future<void> _loadCrops() async {
    final crops = await _dbService.getCrops();
    setState(() {
      _crops = crops;
    });
  }

  Future<void> _showAddCropDialog() async {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    String name = '';
    DateTime plantingDate = DateTime.now();
    double area = 0.0;
    String variety = '';
    double expectedYield = 0.0;
    String notes = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.translate('add_crop')!),
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
                labelText: localizations.translate('area_covered'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => area = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('expected_yield'),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => expectedYield = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'प्रकार/जात',
              ),
              onChanged: (value) => variety = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.translate('description'),
              ),
              maxLines: 3,
              onChanged: (value) => notes = value,
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
              final crop = Crop(
                name: name,
                plantingDate: plantingDate,
                area: area,
                variety: variety,
                expectedYield: expectedYield,
                notes: notes,
              );
              await _dbService.insertCrop(crop);
              _loadCrops();
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
        onPressed: _showAddCropDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: _crops.isEmpty
          ? Center(
              child: Text(
                'कोणतीही पिके नोंद नाही',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: _crops.length,
              itemBuilder: (context, index) {
                final crop = _crops[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(crop.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('क्षेत्रफळ: ${crop.area} एकर'),
                        Text('अपेक्षित उत्पादन: ${crop.expectedYield} क्विंटल'),
                        Text('जात: ${crop.variety}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}