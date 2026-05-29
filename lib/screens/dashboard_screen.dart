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
  if(FinancialData.StartupStatus == 'Excellent') {
    return Colors.green;
  } else if (FinancialData.StartupStatus == 'Stable') {
    return Colors.blue;
  } else if (FinancialData.StartupStatus == 'Warning') {
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
              title: 'Monthly Expenses',
              value: 'LKR ${FinancialData.expenses.toStringAsFixed(2)}',
              icon: Icons.money_off,
            ),
            KpiCard(
              title: 'Profit / Loss', 
              value: 'LKR ${FinancialData.profitLoss.toStringAsFixed((2))}', 
              icon: Icons.account_balance_wallet
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
              value: FinancialData.StartupStatus, 
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
                      'Startup Status: ${FinancialData.StartupStatus}',
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