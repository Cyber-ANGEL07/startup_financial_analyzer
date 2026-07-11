class FinancialCalculator {
  static double calculateBurnRate(double revenue, double expenses) {
    return expenses;
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
  double expenseRatio,
  double profitLoss,
) {

  if (profitLoss < 0 && cashRunway < 6) {
    return 'The startup is operating at a loss with limited cash reserves. Immediate cost reduction and additional funding should be considered.';
  }

  if (expenseRatio >= 80) {
    return 'Operating expenses are consuming most of the revenue. Review operational costs and improve efficiency.';
  }

  if (cashRunway >= 12 && profitLoss > 0) {
    return 'The startup is financially stable. Continue monitoring performance while focusing on sustainable growth.';
  }

  if (burnRate <= 0) {
    return 'The startup is profitable. Consider expanding operations or investing in future growth.';
  }

  return 'Maintain regular financial monitoring and continue improving revenue generation.';
}

  static double calculateProfitLoss(
    double revenue,
    double expenses,
  ) {
    return revenue - expenses;
  }

  static double calculateExpenseRatio(
    double revenue,
    double expenses,
    ) {
      if (revenue <= 0) {
        return 0;
      }
      return (expenses/revenue) * 100;
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

static double forecastNextMonthRevenue(double revenue) {
  return revenue * 1.10;
}

static String generateAiInsight(
  String riskLevel,
  int healthScore,
) {
  if (riskLevel == 'High Risk') {
    return 'The startup is facing significant financial risk. Immediate cost reduction and revenue growth strategies are recommended.';
  }

  if (healthScore >= 80) {
    return 'The startup demonstrates strong financial performance and sustainable growth potential.';
  }

  return 'The startup is financially stable but should continue monitoring expenses and revenue trends.';
}

static double calculateRevenueGrowth(
  double currentRevenue,
  double previousRevenue,
) {
  if (previousRevenue <= 0) {
    return 0;
  }

  return ((currentRevenue - previousRevenue) / previousRevenue) * 100;
}

}