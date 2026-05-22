import 'package:flutter/material.dart';
import 'package:startup_financial_analyzer/screens/dashboard_screen.dart';
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
      home: const DashboardScreen(),
    );
  }
}