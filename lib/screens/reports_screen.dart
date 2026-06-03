import 'package:flutter/material.dart';
import '../models/financial_data.dart';
import '../services/pdf_report_service.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Startup Financial Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Revenue'),
                  trailing: Text(
                    'LKR ${FinancialData.revenue.toStringAsFixed(2)}',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Forecast Revenue'),
                  trailing: Text(
                    'LKR ${FinancialData.forecastRevenue.toStringAsFixed(2)}',
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.money_off),
                  title: const Text('Expenses'),
                  trailing: Text(
                    'LKR ${FinancialData.expenses.toStringAsFixed(2)}',
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: const Text('Profit / Loss'),
                  trailing: Text(
                    'LKR ${FinancialData.profitLoss.toStringAsFixed(2)}',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.local_fire_department),
                  title: const Text('Burn Rate'),
                  trailing: Text(
                    'LKR ${FinancialData.burnRate.toStringAsFixed(2)}',
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.timeline),
                  title: const Text('Cash Runway'),
                  trailing: Text(
                    '${FinancialData.cashRunway.toStringAsFixed(1)} months',
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Health Score'),
                  trailing: Text('${FinancialData.healthScore}/100'),
                ),

                ListTile(
                  leading: const Icon(Icons.warning),
                  title: const Text('Risk Level'),
                  trailing: Text(FinancialData.riskLevel),
                ),

                ListTile(
                  leading: const Icon(Icons.rocket_launch),
                  title: const Text('Startup Status'),
                  trailing: Text(FinancialData.startupStatus),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Recommendation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(FinancialData.recommendation),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    PdfReportService.generateFinancialReport();
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export PDF Report'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}