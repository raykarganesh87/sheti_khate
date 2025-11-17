import 'package:flutter/material.dart';

class MarathiLocalizations {
  static const Map<String, String> _localizedStrings = {
    'app_title': 'शेती खाते',
    'home': 'मुख्य पृष्ठ',
    'expenses': 'खर्च',
    'equipment': 'उपकरणे',
    'chemicals': 'रसायने',
    'crops': 'पिके',
    'reports': 'अहवाल',
    'settings': 'सेटिंग्ज',
    'add_expense': 'खर्च जोडा',
    'add_equipment': 'उपकरण जोडा',
    'add_chemical': 'रसायन जोडा',
    'add_crop': 'पीक जोडा',
    'fertilizer': 'खत',
    'insecticide': 'कीटकनाशक',
    'herbicide': 'तणनाशक',
    'total_expenses': 'एकूण खर्च',
    'total_income': 'एकूण उत्पन्न',
    'profit_loss': 'नफा/तोटा',
    'save': 'जतन करा',
    'cancel': 'रद्द करा',
    'name': 'नाव',
    'date': 'तारीख',
    'amount': 'रक्कम',
    'category': 'श्रेणी',
    'quantity': 'प्रमाण',
    'crop_name': 'पीकाचे नाव',
    'description': 'वर्णन',
    'purchase_date': 'खरेदी तारीख',
    'price': 'किंमत',
    'last_maintenance': 'शेवटची देखभाल',
    'chemical_type': 'रसायन प्रकार',
    'usage_date': 'वापराची तारीख',
    'area_covered': 'झाकलेले क्षेत्रफळ',
    'planting_date': 'रोपणी तारीख',
    'expected_yield': 'अपेक्षित उत्पादन',
    'harvest_date': 'काढपाची तारीख',
  };

  static const LocalizationsDelegate<MarathiLocalizations> delegate = 
      _MarathiLocalizationsDelegate();

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _MarathiLocalizationsDelegate 
    extends LocalizationsDelegate<MarathiLocalizations> {
  const _MarathiLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mr';

  @override
  Future<MarathiLocalizations> load(Locale locale) async {
    return MarathiLocalizations();
  }

  @override
  bool shouldReload(_MarathiLocalizationsDelegate old) => false;
}