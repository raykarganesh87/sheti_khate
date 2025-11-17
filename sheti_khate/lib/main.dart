import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sheti_khate/screens/home_screen.dart';
import 'package:sheti_khate/utils/marathi_localization.dart';
import 'package:sheti_khate/utils/constants.dart';

void main() {
  runApp(const ShetiKhateApp());
}

class ShetiKhateApp extends StatelessWidget {
  const ShetiKhateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'शेती खाते',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'NotoSansDevanagari',
      ),
      localizationsDelegates: const [
        MarathiLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('mr', 'IN'), // Marathi
        Locale('en', 'US'), // English fallback
      ],
      locale: const Locale('mr', 'IN'),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}