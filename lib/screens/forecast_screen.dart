import 'package:flutter/material.dart';
import '../models/financial_data.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final growthAmount =
        FinancialData.forecastRevenue - FinancialData.revenue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue Forecast'),
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
                  'Next Month Forecast',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text('Current Revenue'),
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
                  leading: const Icon(Icons.add_chart),
                  title: const Text('Expected Growth'),
                  trailing: Text(
                    'LKR ${growthAmount.toStringAsFixed(2)}',
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Forecast Insight',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Based on the current simple growth model, the startup is expected to grow by approximately 10% next month.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}