import '../models/financial_data.dart';
import 'trend_data.dart';

class FinancialData {
  static double revenue = 0;
  static double expenses = 0;
  static double cashBalance = 0;
  static double burnRate = 0;
  static double cashRunway = 0;
  static String riskLevel = '';
  static int healthScore = 0;
  static String recommendation = '';
  static double profitLoss = 0;
  static String StartupStatus = '';

  static List<TrendData> trendList = [
    TrendData(month: 'Jan', revenue: 80000, expenses: 100000),
    TrendData(month: 'Feb', revenue: 95000, expenses: 110000),
  TrendData(month: 'Mar', revenue: 120000, expenses: 115000),
  TrendData(month: 'Apr', revenue: 140000, expenses: 125000),
  ];
}