import 'package:flutter/material.dart';
import '../calculations/financial_calculator.dart';
import '../models/financial_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: revenueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Monthly Revenue',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: expensesController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Monthly Expenses',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: cashController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Current Cash Balance',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height:24),
            ElevatedButton(
              onPressed: () {

                if(revenueController.text.isEmpty || expensesController.text.isEmpty || cashController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter all financial values'),
                      ), 
                    );
                    return;
                }


                final revenue = double.tryParse(revenueController.text) ?? 0;
                final expenses = double.tryParse(expensesController.text) ?? 0;
                final cash = double.tryParse(cashController.text) ?? 0;

                if (revenue < 0 || expenses < 0 || cash < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Values cannot be negative'),
                    ),
                  );
                  return;
                } 

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

                final healthScore = FinancialCalculator.calculateHealthScore(
                  burnRate,
                  cashRunway,
                );

                final aiInsight = FinancialCalculator.generateAiInsight(
                  riskLevel,
                  healthScore,
                );

                final startupStatus = FinancialCalculator.calculateStartupStatus(
                  healthScore,
                );

                final recommendation = FinancialCalculator.generateRecommendation(
                  burnRate,
                  cashRunway,
                );

                final forecastRevenue = FinancialCalculator.forecastNextMonthRevenue(
                  revenue,
                );

                final profitLoss = FinancialCalculator.calculateProfitLoss(
                  revenue,
                  expenses,
                );

                setState(() {
                  burnRateResult = burnRate;
                  cashRunwayResult = cashRunway;
                  riskLevelResult = riskLevel;

                  FinancialData.revenue = revenue;
                  FinancialData.expenses = expenses;
                  FinancialData.cashBalance = cash;
                  FinancialData.burnRate = burnRate;
                  FinancialData.cashRunway = cashRunway;
                  FinancialData.riskLevel = riskLevel;
                  FinancialData.healthScore = healthScore;
                  FinancialData.aiInsight = aiInsight;
                  FinancialData.recommendation = recommendation;
                  FinancialData.forecastRevenue = forecastRevenue;

                  final box = Hive.box('financialDataBox');

                  box.put('revenue', revenue);
                  box.put('expenses', expenses);
                  box.put('cashBalance', cash);
                  box.put('burnRate', burnRate);
                  box.put('cashRunway', cashRunway);
                  box.put('riskLevel', riskLevel);
                  box.put('healthScore', healthScore);
                  box.put('aiInsighht', aiInsight);
                  box.put('recommendation', recommendation);
                  box.put('startupStatus', startupStatus);
                  box.put('profitLoss', profitLoss);
                  box.put('forecastRevenue', forecastRevenue);

                  FinancialData.profitLoss = profitLoss;
                  FinancialData.startupStatus = startupStatus;
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