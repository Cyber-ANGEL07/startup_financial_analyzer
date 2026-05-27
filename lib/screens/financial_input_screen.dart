import 'package:flutter/material.dart';

class FinancialInputScreen extends StatefulWidget {
  const FinancialInputScreen({super.key});

  @override
  State<FinancialInputScreen> createState() =>
      _FinancialInputScreenState();
}

class _FinancialInputScreenState
    extends State<FinancialInputScreen> {

  final TextEditingController revenueController =
      TextEditingController();

  final TextEditingController expensesController =
      TextEditingController();

  final TextEditingController cashController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Input'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: revenueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monthly Revenue',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: expensesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monthly Expenses',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: cashController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Current Cash Balance',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height:24),
            ElevatedButton(
              onPressed: () {
                final revenue = double.tryParse(revenueController.text) ?? 0;
                final expenses = double.tryParse(expensesController.text) ?? 0;
                final cash = double.tryParse(cashController.text) ?? 0;

                final burnRate = expenses - revenue;
                final cashRunway = burnRate > 0 ? cash / burnRate : 0;

                String riskLevel;

                if (burnRate <= 0) {
                  riskLevel = 'Low Risk';
                } else if (cashRunway >= 12) {
                  riskLevel = 'Medium Risk';
                } else {
                  riskLevel = 'High Risk';
                }

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Burn Rate: LKR $burnRate| Runway: ${cashRunway.toStringAsFixed(1)}months | Risk: $riskLevel'),
                  ),
                );
              },
              child: Text('Save Financial Data'),
              ),
          ],
        ),
      ),
    );
  }
}