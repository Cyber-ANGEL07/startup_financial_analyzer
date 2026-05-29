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

  static int calculateHealthScore(double burnRate, double cashRunway) {
    if (burnRate <= 0) {
      return 90;
    } else if (cashRunway >= 12) {
      return 75;
    } else if (cashRunway >= 6) {
      return 55;
    } else {
      return 30;
    }
  }

  static String generateRecommendation(
    double burnRate,
    double cashRunway,
  ) {
    if (burnRate <= 0) {
      return 'Startup is profitable. Focus on growth and expansion.';
    } else if (cashRunway >= 12) {
      return 'Financial position is stable. Monitor expenses regularly.';
    } else if (cashRunway >= 6) {
      return 'Reduce unessessary expenses and improve revenue streams.';
    } else {
      return 'Critical financial risk detected. Immediate cost reduction is recommended';
    }
  }

  static double calculateProfitLoss(
    double revenue,
    double expenses,
  ) {
    return revenue - expenses;
  }

  static String calculateStartupStatus(
  int healthScore,
) {
  if (healthScore >= 85) {
    return 'Excellent';
  } else if (healthScore >= 65) {
    return 'Stable';
  } else if (healthScore >= 40) {
    return 'Warning';
  } else {
    return 'Critical';
  }
}

}