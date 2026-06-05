class TrendData {
  final String month;
  final double revenue;
  final double expenses;

  TrendData({
    required this.month,
    required this.revenue,
    required this.expenses,
  });

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'revenue': revenue,
      'expenses': expenses,
    };
  }

  factory TrendData.fromMap(Map data) {
    return TrendData(
      month: data['month'],
      revenue: data['revenue'],
      expenses: data['expenses'],
      );
  }
}