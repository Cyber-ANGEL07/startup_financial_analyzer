import 'package:flutter/material.dart';
import '../models/financial_data.dart';

class FinancialHistoryScreen extends StatelessWidget {
  const FinancialHistoryScreen({super.key});

  String _formatDate(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year;

    int hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';

    hour = hour % 12;
    if (hour == 0) {
      hour = 12;
    }

    return '$day $month $year • $hour:$minute $period';
  }

  String _formatMoney(double value) {
    return 'LKR ${value.toStringAsFixed(2)}';
  }

  Color _riskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final history = [...FinancialData.trendList];

    // Newest records appear first.
    history.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) {
        return 0;
      }

      if (a.createdAt == null) {
        return 1;
      }

      if (b.createdAt == null) {
        return -1;
      }

      return b.createdAt!.compareTo(a.createdAt!);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial History'),
      ),
      body: history.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 60,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No financial records yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Your previous financial analyses will appear here.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final record = history[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      16,
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        '${history.length - index}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: const Text(
                      'Financial Analysis',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      record.createdAt != null
                        ? _formatDate(record.createdAt!)
                        : 'Date unavailable',
                    ),
                    children: [
                      const Divider(),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.trending_up),
                        title: const Text('Revenue'),
                        trailing: Text(
                          _formatMoney(record.revenue),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.money_off),
                        title: const Text('Expenses'),
                        trailing: Text(
                          _formatMoney(record.expenses),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.account_balance_wallet),
                        title: const Text('Cash Balance'),
                        trailing: Text(
                          _formatMoney(record.cashBalance),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.calculate),
                        title: const Text('Profit / Loss'),
                        trailing: Text(
                          _formatMoney(record.profitLoss),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.local_fire_department,
                        ),
                        title: const Text('Burn Rate'),
                        trailing: Text(
                          _formatMoney(record.burnRate),
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
                          '${record.cashRunway.toStringAsFixed(1)} months',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.health_and_safety),
                        title: const Text('Health Score'),
                        trailing: Text(
                          '${record.healthScore.toStringAsFixed(0)}/100',
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
                          record.riskLevel.isEmpty
                              ? 'Not available'
                              : record.riskLevel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _riskColor(record.riskLevel),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}