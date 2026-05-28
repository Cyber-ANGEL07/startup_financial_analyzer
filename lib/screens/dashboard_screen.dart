import 'package:flutter/material.dart';
import 'package:startup_financial_analyzer/models/financial_data.dart';
import '../widgets/kpi_card.dart';

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
              title: 'Burn Rate',
              value: 'LKR ${FinancialData.burnRate.toStringAsFixed(2)}',
              icon: Icons.local_fire_department,
            ),
            KpiCard(
              title: 'Cash Runway',
              value: '${FinancialData.cashRunway.toStringAsFixed(1)} months',
              icon: Icons.timeline,
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