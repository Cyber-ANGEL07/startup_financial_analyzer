import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/financial_data.dart';

class TrendChart extends StatelessWidget {
  const TrendChart({super.key});

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }

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

    return '${date.day} ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final history = List.of(FinancialData.trendList);

    if (history.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.show_chart,
                size: 45,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              Text(
                'No financial trend data yet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Complete a financial analysis to see trends.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Keep the records in chronological order.
    history.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) {
        return 0;
      }

      if (a.createdAt == null) {
        return -1;
      }

      if (b.createdAt == null) {
        return 1;
      }

      return a.createdAt!.compareTo(b.createdAt!);
    });

    final revenueSpots = history.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.revenue,
      );
    }).toList();

    final expenseSpots = history.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.expenses,
      );
    }).toList();

    final allValues = [
      ...history.map((item) => item.revenue),
      ...history.map((item) => item.expenses),
    ];

    final highestValue = allValues.reduce(
      (a, b) => a > b ? a : b,
    );

    final chartMaxY = highestValue == 0
        ? 100000.0
        : highestValue * 1.2;

    return SizedBox(
      height: 280,
      child: Column(
        children: [
          // Chart legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(
                color: Colors.green,
                label: 'Revenue',
              ),
              const SizedBox(width: 24),
              _LegendItem(
                color: Colors.red,
                label: 'Expenses',
              ),
            ],
          ),

          const SizedBox(height: 12),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Give each record enough horizontal space.
                // The chart will scroll when there are many records.
                final chartWidth = math.max(
                  constraints.maxWidth,
                  history.length * 75.0,
                );

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: chartWidth,
                    child: LineChart(
                      LineChartData(
                        minY: 0,
                        maxY: chartMaxY,

                        minX: 0,
                        maxX: history.length > 1
                            ? (history.length - 1).toDouble()
                            : 1,

                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: chartMaxY / 5,
                          verticalInterval: 1,
                        ),

                        borderData: FlBorderData(
                          show: true,
                        ),

                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                final index = spot.x.toInt();

                                if (index < 0 ||
                                    index >= history.length) {
                                  return null;
                                }

                                final label = spot.barIndex == 0
                                    ? 'Revenue'
                                    : 'Expenses';

                                return LineTooltipItem(
                                  '$label\nLKR ${spot.y.toStringAsFixed(2)}',
                                  const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),

                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),

                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),

                          leftTitles: AxisTitles(
                            axisNameWidget: const Text(
                              'LKR',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 45,
                              interval: chartMaxY / 5,
                              getTitlesWidget: (value, meta) {
                                if (value < 0) {
                                  return const SizedBox();
                                }

                                if (value >= 1000000) {
                                  return Text(
                                    '${(value / 1000000).toStringAsFixed(1)}M',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                }

                                if (value >= 1000) {
                                  return Text(
                                    '${(value / 1000).toStringAsFixed(0)}K',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  );
                                }

                                return Text(
                                  value.toStringAsFixed(0),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ),

                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 35,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();

                                if (index < 0 ||
                                    index >= history.length) {
                                  return const SizedBox();
                                }

                                final record = history[index];

                                final label = record.createdAt != null
                                    ? _formatDate(record.createdAt)
                                    : 'Record ${index + 1}';

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                  ),
                                  child: Text(
                                    label,
                                    style: const TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        lineBarsData: [
                          LineChartBarData(
                            spots: revenueSpots,
                            isCurved: true,
                            barWidth: 3,
                            color: Colors.green,
                            dotData: const FlDotData(
                              show: true,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.green.withValues(
                                alpha: 0.08,
                              ),
                            ),
                          ),

                          LineChartBarData(
                            spots: expenseSpots,
                            isCurved: true,
                            barWidth: 3,
                            color: Colors.red,
                            dotData: const FlDotData(
                              show: true,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.red.withValues(
                                alpha: 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}