import 'package:flutter/material.dart';
import '../calculations/financial_calculator.dart';

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

  double burnRateResult = 0;
  double cashRunwayResult = 0;
  String riskLevelResult = '';

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

                final burnRate = FinancialCalculator.calculateBurnRate(
                  revenue,
                  expenses,
                );

                final cashRunway = FinancialCalculator.calculateCashRunway(
                  cash,
                  burnRate,
                );

                final riskLevel = FinancialCalculator.calculateRiskLevel(
                  burnRate,
                  cashRunway,
                );

                setState(() {
                  burnRateResult = burnRate;
                  cashRunwayResult = cashRunway;
                  riskLevelResult = riskLevel;
                });

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Financial data calculated successfully'),
  ),
);
              },
              child: Text('Save Financial Data'),
              ),
            
            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Calculated Results',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Burn Rate: LKR ${burnRateResult.toStringAsFixed(2)}'),
                    Text('Cash Runway: ${cashRunwayResult.toStringAsFixed(1)} months'),
                    Text('Risk Level: $riskLevelResult'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}