import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/financial_data.dart';
import '../models/trend_data.dart';

class UserDataService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Box get _box => Hive.box('financialDataBox');

  static String get _uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    return user.uid;
  }

  static String _key(String name) {
    return '${_uid}_$name';
  }

  static Future<void> saveFinancialData() async {
    await _box.put(_key('revenue'), FinancialData.revenue);
    await _box.put(_key('expenses'), FinancialData.expenses);
    await _box.put(_key('cashBalance'), FinancialData.cashBalance);
    await _box.put(_key('burnRate'), FinancialData.burnRate);
    await _box.put(_key('cashRunway'), FinancialData.cashRunway);

    await _box.put(_key('riskLevel'), FinancialData.riskLevel);
    await _box.put(_key('healthScore'), FinancialData.healthScore);
    await _box.put(_key('aiInsight'), FinancialData.aiInsight);
    await _box.put(_key('recommendation'), FinancialData.recommendation);
    await _box.put(_key('startupStatus'), FinancialData.startupStatus);

    await _box.put(_key('profitLoss'), FinancialData.profitLoss);
    await _box.put(_key('forecastRevenue'), FinancialData.forecastRevenue);
    await _box.put(_key('expenseRatio'), FinancialData.expenseRatio);
    await _box.put(_key('revenueGrowth'), FinancialData.revenueGrowth);

    await _box.put(
      _key('trendList'),
      FinancialData.trendList
          .map((trend) => trend.toMap())
          .toList(),
    );
  }

  static void clearCurrentUserData() {
    FinancialData.revenue = 0.0;
    FinancialData.expenses = 0.0;
    FinancialData.cashBalance = 0.0;
    FinancialData.burnRate = 0.0;
    FinancialData.cashRunway = 0.0;

    FinancialData.riskLevel = '';
    FinancialData.healthScore = 0;
    FinancialData.aiInsight = '';
    FinancialData.recommendation = '';
    FinancialData.startupStatus = '';

    FinancialData.profitLoss = 0.0;
    FinancialData.forecastRevenue = 0.0;
    FinancialData.expenseRatio = 0.0;
    FinancialData.revenueGrowth = 0.0;

    FinancialData.trendList = [];
  }

  static Future<void> loadCurrentUserData() async {
    clearCurrentUserData();

    final user = _auth.currentUser;

    if (user == null) {
      return;
    }

    FinancialData.revenue =
        (_box.get(_key('revenue'), defaultValue: 0.0) as num).toDouble();

    FinancialData.expenses =
        (_box.get(_key('expenses'), defaultValue: 0.0) as num).toDouble();

    FinancialData.cashBalance =
        (_box.get(_key('cashBalance'), defaultValue: 0.0) as num).toDouble();

    FinancialData.burnRate =
        (_box.get(_key('burnRate'), defaultValue: 0.0) as num).toDouble();

    FinancialData.cashRunway =
        (_box.get(_key('cashRunway'), defaultValue: 0.0) as num).toDouble();

    FinancialData.riskLevel =
        _box.get(_key('riskLevel'), defaultValue: '');

    FinancialData.healthScore =
        _box.get(_key('healthScore'), defaultValue: 0);

    FinancialData.aiInsight =
        _box.get(_key('aiInsight'), defaultValue: '');

    FinancialData.recommendation =
        _box.get(_key('recommendation'), defaultValue: '');

    FinancialData.startupStatus =
        _box.get(_key('startupStatus'), defaultValue: '');

    FinancialData.profitLoss =
        (_box.get(_key('profitLoss'), defaultValue: 0.0) as num).toDouble();

    FinancialData.forecastRevenue =
        (_box.get(_key('forecastRevenue'), defaultValue: 0.0) as num)
            .toDouble();

    FinancialData.expenseRatio =
        (_box.get(_key('expenseRatio'), defaultValue: 0.0) as num)
            .toDouble();

    FinancialData.revenueGrowth =
        (_box.get(_key('revenueGrowth'), defaultValue: 0.0) as num)
            .toDouble();

    final savedTrendList = _box.get(_key('trendList'));

    if (savedTrendList != null && savedTrendList is List) {
      FinancialData.trendList = savedTrendList
          .map<TrendData>(
            (item) => TrendData.fromMap(
              Map.from(item),
            ),
          )
          .toList();
    }
  }
}