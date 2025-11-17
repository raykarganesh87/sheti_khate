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
    return Scaffold(
      appBar: AppBar(
        title: const Text('शेती खाते'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'खर्च'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'साधने'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'रासायनिक'),
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'पिके'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'अहवाल'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'सेटिंग्ज'),
        ],
      ),
    );
  }
}
