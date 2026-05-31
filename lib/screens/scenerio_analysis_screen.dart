import 'package:flutter/material.dart';
import '../models/financial_data.dart';
import '../calculations/financial_calculator.dart';

class ScenarioAnalysisScreen extends StatefulWidget {
  const ScenarioAnalysisScreen({super.key});

  @override
  State<ScenarioAnalysisScreen> createState() => _ScenarioAnalysisScreenState();
}

class _ScenarioAnalysisScreenState extends State<ScenarioAnalysisScreen> {
  double newBurnRate = 0;
  double newRunway = 0;

  void calculateScenario() {
    final reducedExpenses = FinancialData.expenses * 0.8;

    final calculatedBurnRate =
        FinancialCalculator.calculateBurnRate(
      FinancialData.revenue,
      reducedExpenses,
    );

    final calculatedRunway =
        FinancialCalculator.calculateCashRunway(
      FinancialData.cashBalance,
      calculatedBurnRate,
    );

    setState(() {
      newBurnRate = calculatedBurnRate;
      newRunway = calculatedRunway;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scenario Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'What if expenses are reduced by 20%?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateScenario,
              child: const Text('Run Scenario'),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Scenerio Result',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),
                  Text(
                    'Current Burn Rate: LKR ${FinancialData.burnRate.toStringAsFixed(2)}',                    
                  ),
                  Text(
                    'New Burn Rate: LKR ${newBurnRate.toStringAsFixed(2)}'
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current Runway: ${FinancialData.cashRunway.toStringAsFixed(1)} months',
                  ),
                  Text(
                    'New Runway: ${newRunway.toStringAsFixed(1)} months',
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