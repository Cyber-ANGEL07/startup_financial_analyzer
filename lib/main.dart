import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/main_navigation_screen.dart';
import 'screens/login_screen.dart';
import 'services/user_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
  await dotenv.load(fileName: ".env");
  print('Gemini key loaded: ${dotenv.env['GEMINI_API_KEY'] != null && dotenv.env['GEMINI_API_KEY']!.isNotEmpty}');
} catch (e) {
  print('No .env file found. Gemini AI will use fallback behaviour.');
}

  await Hive.initFlutter();

  await Hive.openBox('financialDataBox');

  await Firebase.initializeApp();

  // Load financial data for the currently logged-in user.
  if (FirebaseAuth.instance.currentUser != null) {
    await UserDataService.loadCurrentUserData();
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
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : const MainNavigationScreen(),
    );
  }
}