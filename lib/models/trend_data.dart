class TrendData {
  final String month;
  final DateTime? createdAt;

  final double revenue;
  final double expenses;
  final double cashBalance;
  final double profitLoss;
  final double burnRate;
  final double cashRunway;
  final double healthScore;

  final String riskLevel;

  TrendData({
    required this.month,
    required this.createdAt,
    required this.revenue,
    required this.expenses,
    required this.cashBalance,
    required this.profitLoss,
    required this.burnRate,
    required this.cashRunway,
    required this.healthScore,
    required this.riskLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'createdAt': createdAt?.toIso8601String(),
      'revenue': revenue,
      'expenses': expenses,
      'cashBalance': cashBalance,
      'profitLoss': profitLoss,
      'burnRate': burnRate,
      'cashRunway': cashRunway,
      'healthScore': healthScore,
      'riskLevel': riskLevel,
    };
  }

  factory TrendData.fromMap(Map data) {
    return TrendData(
      month: data['month']?.toString() ?? '',
      createdAt: data['createdAt'] != null
        ? DateTime.tryParse(data['createdAt'].toString())
        : null,
      revenue: (data['revenue'] ?? 0).toDouble(),
      expenses: (data['expenses'] ?? 0).toDouble(),
      cashBalance: (data['cashBalance'] ?? 0).toDouble(),
      profitLoss: (data['profitLoss'] ?? 0).toDouble(),
      burnRate: (data['burnRate'] ?? 0).toDouble(),
      cashRunway: (data['cashRunway'] ?? 0).toDouble(),
      healthScore: (data['healthScore'] ?? 0).toDouble(),
      riskLevel: data['riskLevel']?.toString() ?? '',
    );
  }
}