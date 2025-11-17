import 'package:flutter/material.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.translate('total_expenses')!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('₹50,000', style: const TextStyle(fontSize: 24, color: Colors.red)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.translate('total_income')!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('₹75,000', style: const TextStyle(fontSize: 24, color: Colors.green)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.translate('profit_loss')!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('₹25,000', style: const TextStyle(fontSize: 24, color: Colors.green)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'तपशीलवार अहवाल',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                title: Text(localizations.translate('expenses')!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to detailed expenses report
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(localizations.translate('equipment')!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to equipment report
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(localizations.translate('chemicals')!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to chemical report
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(localizations.translate('crops')!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to crop report
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}