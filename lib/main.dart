import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const StartupRiskAnalyzerApp());
}

class StartupRiskAnalyzerApp extends StatelessWidget {
  const StartupRiskAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Financial Analyzer',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}