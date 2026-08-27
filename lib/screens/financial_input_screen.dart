import 'package:flutter/material.dart';
import '../calculations/financial_calculator.dart';
import '../models/financial_data.dart';
import '../models/trend_data.dart';
import '../services/ai_financial_service.dart';
import '../services/firestore_service.dart';
import '../services/user_data_service.dart';

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
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Monthly Revenue',
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    color: Colors.green,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: expensesController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Monthly Expenses',
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.trending_down,
                    color: Colors.red,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: cashController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Current Cash Balance',
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
            ),

            SizedBox(height:24),
            ElevatedButton(
              onPressed: () async {
                print("Analyze Data button clicked");

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

                final aiResponse = await AIFinancialService().generateFinancialInsight(
                  revenue: revenue,
                  expenses: expenses,
                  burnRate: burnRate,
                  cashRunway: cashRunway,
                  expenseRatio: expenseRatio,
                  revenueGrowth: revenueGrowth,
                  riskLevel: riskLevel,
                  healthScore: healthScore,
                );

                print("AI Response: $aiResponse");

                if (aiResponse == null) {
                  print("Using LOCAL fallback insight");
                } else {
                  print("Using GEMINI AI insight");
                }

                String aiInsight = aiResponse ??
                    FinancialCalculator.generateAiInsight(
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

                  FinancialData.trendList.add(
                    TrendData(
                      month: currentMonth,
                      createdAt: DateTime.now(),
                      revenue: revenue,
                      expenses: expenses,
                      cashBalance: cash,
                      profitLoss: profitLoss,
                      burnRate: burnRate,
                      cashRunway: cashRunway,
                      healthScore: healthScore.toDouble(),
                      riskLevel: riskLevel,
                    ),
                  );

                  FinancialData.profitLoss = profitLoss;
                  FinancialData.startupStatus = startupStatus;
                });

                await UserDataService.saveFinancialData();

                await FirestoreService().saveFinancialData(
                  revenue: revenue,
                  expenses: expenses,
                  cashBalance: cash,
                  burnRate: burnRate,
                  cashRunway: cashRunway,
                  riskLevel: riskLevel,
                  healthScore: healthScore,
                  recommendation: recommendation,
                  aiInsight: aiInsight,
                  profitLoss: profitLoss,
                  forecastRevenue: forecastRevenue,
                  expenseRatio: expenseRatio,
                  revenueGrowth: revenueGrowth,
                  startupStatus: startupStatus,
                );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Financial data calculated successfully'),
                    ),
                  );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: const Color(0xFF5B5BD6),
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
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
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.warning_amber,
                          color: Colors.orange,
                        ),
                      ),
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
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.timeline,
                          color: Colors.blue,
                        ),
                      ),
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