import 'package:flutter/material.dart';
import '../calculations/financial_calculator.dart';
import '../models/financial_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/trend_data.dart';

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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter Financial Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Provide the latest monthly financial information to analyse your startup\'s financial health.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 20),

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

                final currentMonth = DateTime.now().month.toString();

                double previousRevenue = 0;

                  if (FinancialData.trendList.isNotEmpty) {
                    previousRevenue = FinancialData.trendList.last.revenue;
                  }

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

                final startupStatus = FinancialCalculator.calculateStartupStatus(
                  healthScore,
                );

                final forecastRevenue = FinancialCalculator.forecastNextMonthRevenue(
                  revenue,
                );

                final profitLoss = FinancialCalculator.calculateProfitLoss(
                  revenue,
                  expenses,
                );

                final expenseRatio = FinancialCalculator.calculateExpenseRatio(
                  revenue, 
                  expenses
                );

                final revenueGrowth = FinancialCalculator.calculateRevenueGrowth(
                  revenue,
                  previousRevenue,
                );

                final aiInsight = FinancialCalculator.generateAiInsight(
                  riskLevel,
                  healthScore,
                  expenseRatio,
                  revenueGrowth,
                  profitLoss,
                  cashRunway,
                );

                final recommendation = FinancialCalculator.generateRecommendation(
                  burnRate,
                  cashRunway,
                  expenseRatio,
                  profitLoss,
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
                  FinancialData.expenseRatio = expenseRatio;
                  FinancialData.revenueGrowth = revenueGrowth;

                  final box = Hive.box('financialDataBox');

                  box.put('revenue', revenue);
                  box.put('expenses', expenses);
                  box.put('cashBalance', cash);
                  box.put('burnRate', burnRate);
                  box.put('cashRunway', cashRunway);
                  box.put('riskLevel', riskLevel);
                  box.put('healthScore', healthScore);
                  box.put('aiInsight', aiInsight);
                  box.put('recommendation', recommendation);
                  box.put('startupStatus', startupStatus);
                  box.put('profitLoss', profitLoss);
                  box.put('forecastRevenue', forecastRevenue);
                  box.put('expenseRatio', expenseRatio);
                  box.put('revenueGrowth', revenueGrowth);

                  FinancialData.trendList.add(
                    TrendData(
                      month: currentMonth, 
                      revenue: revenue, 
                      expenses: expenses,
                      ),
                  );

                  box.put(
                    'trendList',
                    FinancialData.trendList.map((trend) => trend.toMap()).toList(),
                  );

                  FinancialData.profitLoss = profitLoss;
                  FinancialData.startupStatus = startupStatus;
                });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Financial data calculated successfully'),
                    ),
                  );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics_outlined),
                  SizedBox(width: 8),
                  Text(
                    'Analyse Financial Data',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.local_fire_department),
                      title: const Text('Burn Rate'),
                      trailing: Text(
                        'LKR ${burnRateResult.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.timeline),
                      title: const Text('Cash Runway'),
                      trailing: Text(
                        '${cashRunwayResult.toStringAsFixed(1)} months',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.warning_amber),
                      title: const Text('Risk Level'),
                      trailing: Text(
                        riskLevelResult.isEmpty ? 'Not Analysed' : riskLevelResult,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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