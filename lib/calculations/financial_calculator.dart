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
  if (cashRunway >= 24) {
    return 'Low Risk';
  } else if (cashRunway >= 6) {
    return 'Medium Risk';
  } else {
    return 'High Risk';
  }
}

  static int calculateHealthScore(double burnRate, double cashRunway) {
  if (cashRunway >= 24) {
    return 90;
  } else if (cashRunway >= 6) {
    return 75;
  } else {
    return 40;
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
  double expenseRatio,
  double revenueGrowth,
  double profitLoss,
  double cashRunway,
  ) {
    if (riskLevel == 'High Risk' &&
        cashRunway < 6 &&
        profitLoss < 0) {
      return 'The startup is experiencing significant financial pressure. '
          'The business is operating at a loss and has a limited cash runway. '
          'Immediate cost control and revenue improvement strategies should be prioritised.';
    }

    if (expenseRatio >= 80) {
      return 'A high proportion of revenue is being consumed by operating expenses. '
          'The startup should review its cost structure and identify opportunities to improve operational efficiency.';
    }

    if (revenueGrowth < 0) {
      return 'Revenue has declined compared to the previous financial record. '
          'The startup should investigate the cause of the decline and review its revenue generation strategies.';
    }

    if (revenueGrowth > 10 &&
        profitLoss > 0 &&
        healthScore >= 80) {
      return 'The startup demonstrates positive revenue growth, profitability and strong financial health. '
          'The current financial position indicates sustainable growth potential.';
    }

    if (cashRunway < 6) {
      return 'The available cash runway is limited. '
          'The startup should closely monitor cash reserves and consider reducing expenses or improving cash inflows.';
    }

    return 'The startup is financially stable based on the current financial indicators. '
        'Regular monitoring of revenue, expenses and financial trends is recommended.';
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