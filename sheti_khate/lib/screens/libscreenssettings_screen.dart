import 'package:flutter/material.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              localizations.translate('settings')!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                title: const Text('भाषा बदला'),
                subtitle: const Text('Marathi / English'),
                trailing: const Icon(Icons.language),
                onTap: () {
                  // Language change functionality
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('डेटा बॅकअप करा'),
                trailing: const Icon(Icons.backup),
                onTap: () {
                  // Backup functionality
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('मदत'),
                trailing: const Icon(Icons.help),
                onTap: () {
                  // Help functionality
                },
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                'शेती खाते v1.0',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}