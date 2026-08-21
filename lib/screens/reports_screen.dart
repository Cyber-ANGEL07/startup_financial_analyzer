import 'package:flutter/material.dart';
import '../models/financial_data.dart';
import '../services/pdf_report_service.dart';
import 'financial_history_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Startup Financial Report',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Text(
                    'Financial Performance Analysis',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Financial Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),

                ListTile(
                  leading: Icon(Icons.trending_up, color: iconColor),
                  title: const Text('Revenue'),
                  trailing: Text(
                    'LKR ${FinancialData.revenue.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.trending_up, color: iconColor),
                  title: const Text('Forecast Revenue'),
                  trailing: Text(
                    'LKR ${FinancialData.forecastRevenue.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.money_off, color: iconColor),
                  title: const Text('Expenses'),
                  trailing: Text(
                    'LKR ${FinancialData.expenses.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: iconColor),
                  title: const Text('Profit / Loss'),
                  trailing: Text(
                    'LKR ${FinancialData.profitLoss.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.pie_chart, color: iconColor),
                  title: const Text('Expense Ratio'),
                  trailing: Text(
                    '${FinancialData.expenseRatio.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.show_chart, color: iconColor),
                  title: const Text('Revenue Growth'),
                  trailing: Text(
                    '${FinancialData.revenueGrowth.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Performance Indicators',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                ListTile(
                  leading: Icon(Icons.local_fire_department, color: iconColor),
                  title: const Text('Burn Rate'),
                  trailing: Text(
                    'LKR ${FinancialData.burnRate.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.timeline, color: iconColor),
                  title: const Text('Cash Runway'),
                  trailing: Text(
                    '${FinancialData.cashRunway.toStringAsFixed(1)} months',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.favorite, color: iconColor),
                  title: const Text('Health Score'),
                  trailing: Text(
                    '${FinancialData.healthScore}/100',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.warning, color: iconColor),
                  title: const Text('Risk Level'),
                  trailing: Text(
                    FinancialData.riskLevel,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.rocket_launch, color: iconColor),
                  title: const Text('Startup Status'),
                  trailing: Text(
                    FinancialData.startupStatus,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Recommendation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    FinancialData.recommendation,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Financial Insight',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    FinancialData.aiInsight,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),

                const SizedBox(height: 30),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      PdfReportService.generateFinancialReport();
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Export PDF Report'),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinancialHistoryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('View Financial History'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}