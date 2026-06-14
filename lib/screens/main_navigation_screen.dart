import 'package:flutter/material.dart';
import 'package:startup_financial_analyzer/screens/financial_input_screen.dart';
import 'dashboard_screen.dart';
import 'scenerio_analysis_screen.dart';
import 'reports_screen.dart';
import 'forecast_screen.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    DashboardScreen(),
    FinancialInputScreen(),
    ScenarioAnalysisScreen(),
    ForecastScreen(),
    ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text('Startup Financial Analyzer'),
    actions: [
      IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () async {
          await AuthService().logout();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
      ),
    ],
  ),
  body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note),
            label: 'Input',
          ),
          NavigationDestination(
            icon: Icon(Icons.description),
            label: 'Scenerio',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart), 
            label: 'Forecast'
          ),
          NavigationDestination(
            icon: Icon(Icons.description),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}