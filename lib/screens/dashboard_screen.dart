import 'package:flutter/material.dart';
import 'package:startup_financial_analyzer/models/financial_data.dart';
import '../widgets/kpi_card.dart';
import '../widgets/trend_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

Color getRiskColor() {
  if (FinancialData.riskLevel == 'Low Risk') {
    return Colors.green;
  } else if (FinancialData.riskLevel == 'Medium Risk') {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

Color getStatusColor() {
  if(FinancialData.startupStatus == 'Excellent') {
    return Colors.green;
  } else if (FinancialData.startupStatus == 'Stable') {
    return Colors.blue;
  } else if (FinancialData.startupStatus == 'Warning') {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Startup Financial Overview',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            KpiCard(
              title: 'Monthly Revenue',
              value: 'LKR ${FinancialData.revenue.toStringAsFixed(2)}',
              icon: Icons.trending_up,
            ),
            KpiCard(
              title: 'Forecast Revenue',
              value: 'LKR ${FinancialData.forecastRevenue.toStringAsFixed(2)}',
              icon: Icons.money_off,
            ),
            KpiCard(
              title: 'Monthly Expenses',
              value: 'LKR ${FinancialData.expenses.toStringAsFixed(2)}',
              icon: Icons.trending_up,
            ),
            KpiCard(
              title: 'Profit / Loss', 
              value: 'LKR ${FinancialData.profitLoss.toStringAsFixed(2)}', 
              icon: Icons.account_balance_wallet
              ),
            KpiCard(
              title: 'Expense Ratio',
              value: '${FinancialData.expenseRatio.toStringAsFixed(1)}%',
              icon: Icons.pie_chart,
            ),
            KpiCard(
              title: 'Revenue Growth',
              value: '${FinancialData.revenueGrowth.toStringAsFixed(1)}%',
              icon: Icons.show_chart,
            ),
            KpiCard(
              title: 'Burn Rate',
              value: 'LKR ${FinancialData.burnRate.toStringAsFixed(2)}',
              icon: Icons.local_fire_department,
            ),
            KpiCard(
              title: 'Cash Runway',
              value: '${FinancialData.cashRunway.toStringAsFixed(1)} months',
              icon: Icons.timeline,
            ),
            KpiCard(
              title: 'Health Score', 
              value: '${FinancialData.healthScore}/100', 
              icon: Icons.favorite
            ),
            KpiCard(
              title: 'Startup Status', 
              value: FinancialData.startupStatus, 
              icon: Icons.rocket_launch
              ),

            Card(
              color: getStatusColor(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.rocket_launch,
                      color: Colors.white,
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Startup Status: ${FinancialData.startupStatus}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 ),
                ],
              ),
            ),
          ),

            const SizedBox(height: 24),

            const Text(
              'Revenue Trend',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: TrendChart(),
                ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Financial Recommendation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),  

          const SizedBox(height: 10),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                FinancialData.recommendation,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

const Text(
  'AI Financial Insight',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),

Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Text(
      FinancialData.aiInsight,
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
  ),
),

            SizedBox(height: 24),

            Text(
              'Risk Assessment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Card(
              color: getRiskColor(),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color:Colors.white,
                    ),

                    SizedBox(width: 12),
                    Expanded(child: 
                    Text(
                      '${FinancialData.riskLevel} Detected',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}