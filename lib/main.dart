import 'package:flutter/material.dart';
import 'screens/main_navigation_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/financial_data.dart';
import 'models/trend_data.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('financialDataBox');

  final box = Hive.box('financialDataBox');

FinancialData.revenue = box.get('revenue', defaultValue: 0.0);
FinancialData.expenses = box.get('expenses', defaultValue: 0.0);
FinancialData.cashBalance = box.get('cashBalance', defaultValue: 0.0);
FinancialData.burnRate = box.get('burnRate', defaultValue: 0.0);
FinancialData.cashRunway = box.get('cashRunway', defaultValue: 0.0);

FinancialData.riskLevel = box.get('riskLevel', defaultValue: '');
FinancialData.healthScore = box.get('healthScore', defaultValue: 0);
FinancialData.aiInsight = box.get('aiInsight', defaultValue: '');
FinancialData.recommendation = box.get('recommendation', defaultValue: '');
FinancialData.startupStatus = box.get('startupStatus', defaultValue: '');
FinancialData.profitLoss = box.get('profitLoss', defaultValue: 0.0);
FinancialData.forecastRevenue = box.get('forecastRevenue', defaultValue: 0.0);

final savedTrendList = box.get('trendList');

if (savedTrendList != null) {
  FinancialData.trendList = savedTrendList.map<TrendData>((item) => TrendData.fromMap(Map.from(item))).toList();
}

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
      home: const MainNavigationScreen(),
    );
  }
}