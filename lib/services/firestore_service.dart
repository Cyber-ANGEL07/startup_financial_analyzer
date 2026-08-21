import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveFinancialData({
    required double revenue,
    required double expenses,
    required double cashBalance,
    required double burnRate,
    required double cashRunway,
    required String riskLevel,
    required int healthScore,
    required String recommendation,
    required String aiInsight,
    required double profitLoss,
    required double forecastRevenue,
    required double expenseRatio,
    required double revenueGrowth,
    required String startupStatus,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('financialData')
        .add({
      'revenue': revenue,
      'expenses': expenses,
      'cashBalance': cashBalance,
      'burnRate': burnRate,
      'cashRunway': cashRunway,
      'riskLevel': riskLevel,
      'healthScore': healthScore,
      'recommendation': recommendation,
      'aiInsight': aiInsight,
      'profitLoss': profitLoss,
      'forecastRevenue': forecastRevenue,
      'expenseRatio': expenseRatio,
      'revenueGrowth': revenueGrowth,
      'startupStatus': startupStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}