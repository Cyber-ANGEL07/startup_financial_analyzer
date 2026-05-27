class FinancialCalculator {
  static double calculateBurnRate(double revenue, double expenses) {
    return expenses - revenue;
  }

  static double calculateCashRunway(double cashBalance, double burnRate) {
    if (burnRate <= 0) {
      return 0;
    }
    return cashBalance / burnRate;
  }

  static String calculateRiskLevel(double burnRate, double cashRunway) {
    if (burnRate <= 0) {
      return 'Low Risk';
    } else if (cashRunway >= 12) {
      return 'Medium Risk';
    } else {
      return 'High Risk';
    }
  }
}