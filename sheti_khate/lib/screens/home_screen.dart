import 'package:flutter/material.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';
import 'expense_screen.dart';
import 'equipment_screen.dart';
import 'chemicals_screen.dart';
import 'crop_management_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ExpenseScreen(),
    const EquipmentScreen(),
    const ChemicalsScreen(),
    const CropManagementScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = MarathiLocalizations.delegate.currentLocalized(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('app_title')!, style: const TextStyle(fontSize: 20)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.monetization_on),
            label: localizations.translate('expenses'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.construction),
            label: localizations.translate('equipment'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_florist),
            label: localizations.translate('chemicals'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.agriculture),
            label: localizations.translate('crops'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart),
            label: localizations.translate('reports'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: localizations.translate('settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}