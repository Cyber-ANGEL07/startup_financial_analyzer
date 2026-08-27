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

  String selectedVariable = 'Expenses';
  double percentageChange = 20;
  bool isIncrease = false;

  void calculateScenario() {
  final multiplier = isIncrease
      ? 1 + (percentageChange / 100)
      : 1 - (percentageChange / 100);

  double scenarioRevenue = FinancialData.revenue;
  double scenarioExpenses = FinancialData.expenses;
  double scenarioCash = FinancialData.cashBalance;

  if (selectedVariable == 'Revenue') {
    scenarioRevenue = FinancialData.revenue * multiplier;
  } else if (selectedVariable == 'Expenses') {
    scenarioExpenses = FinancialData.expenses * multiplier;
  } else if (selectedVariable == 'Cash Balance') {
    scenarioCash = FinancialData.cashBalance * multiplier;
  }

  final calculatedBurnRate =
      FinancialCalculator.calculateBurnRate(
    scenarioRevenue,
    scenarioExpenses,
  );

  final calculatedRunway =
      FinancialCalculator.calculateCashRunway(
    scenarioCash,
    calculatedBurnRate,
  );

  setState(() {
    newBurnRate = calculatedBurnRate;
    newRunway = calculatedRunway;
  });
}

Widget _buildResultColumn(
  BuildContext context,
  String title,
  double burnRate,
  double runway, {
  bool highlighted = false,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: highlighted
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 14),

        const Text(
          'Burn Rate',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          'LKR ${burnRate.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Cash Runway',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          '${runway.toStringAsFixed(1)} months',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget _buildScenarioChange(BuildContext context) {
  double currentValue;
  double scenarioValue;

  if (selectedVariable == 'Revenue') {
    currentValue = FinancialData.revenue;
  } else if (selectedVariable == 'Expenses') {
    currentValue = FinancialData.expenses;
  } else {
    currentValue = FinancialData.cashBalance;
  }

  final multiplier = isIncrease
      ? 1 + (percentageChange / 100)
      : 1 - (percentageChange / 100);

  scenarioValue = currentValue * multiplier;

  final difference = scenarioValue - currentValue;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedVariable,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: Text(
                'LKR ${currentValue.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),

            const Icon(Icons.arrow_forward),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                'LKR ${scenarioValue.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          '${difference >= 0 ? '+' : ''}'
          'LKR ${difference.toStringAsFixed(0)} '
          '(${isIncrease ? '+' : '-'}'
          '${percentageChange.toStringAsFixed(0)}%)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: difference >= 0
                ? Colors.green
                : Colors.red,
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scenario Analysis'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.tune,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer,
                  size: 26,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scenario Analysis',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Explore the impact of changing your financial assumptions.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
                
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedVariable,
              decoration: InputDecoration(
                labelText: 'Financial Variable',
                prefixIcon: const Icon(Icons.account_balance_wallet),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Expenses',
                  child: Text('Expenses'),
                ),
                DropdownMenuItem(
                  value: 'Revenue',
                  child: Text('Revenue'),
                ),
                DropdownMenuItem(
                  value: 'Cash Balance',
                  child: Text('Cash Balance'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedVariable = value;
                });
              },
            ),

            const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Adjustment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          isIncrease = false;
                        });
                      },
                      icon: const Icon(Icons.arrow_downward),
                      label: const Text('Decrease'),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: !isIncrease
                            ? Theme.of(context)
                                .colorScheme
                                .primaryContainer
                            : null,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          isIncrease = true;
                        });
                      },
                      icon: const Icon(Icons.arrow_upward),
                      label: const Text('Increase'),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isIncrease
                            ? Theme.of(context)
                                .colorScheme
                                .primaryContainer
                            : null,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                '${percentageChange.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Slider(
                value: percentageChange,
                min: 5,
                max: 50,
                divisions: 9,
                label: '${percentageChange.toStringAsFixed(0)}%',
                onChanged: (value) {
                  setState(() {
                    percentageChange = value;
                  });
                },
              ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: calculateScenario,
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'Run Scenario',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.analytics_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Scenario Result',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildScenarioChange(context),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildResultColumn(
                          context,
                          'Current',
                          FinancialData.burnRate,
                          FinancialData.cashRunway,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _buildResultColumn(
                          context,
                          'Scenario',
                          newBurnRate,
                          newRunway,
                          highlighted: true,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  if (newRunway > 0) ...[
                    const Divider(),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(
                          newRunway >= FinancialData.cashRunway
                              ? Icons.trending_up
                              : Icons.trending_down,
                          color: newRunway >= FinancialData.cashRunway
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            newRunway >= FinancialData.cashRunway
                                ? 'This scenario improves the cash runway.'
                                : 'This scenario reduces the cash runway.',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: newRunway >= FinancialData.cashRunway
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}