import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/financial_data.dart';

class TrendChart extends StatelessWidget {
  const TrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: FinancialData.trendList.asMap().entries.map((entry) {
                return FlSpot(
                  entry.key.toDouble(),
                  entry.value.revenue,
                );
              }).toList(),
              isCurved: true,
              barWidth: 3,
            ),
            LineChartBarData(
              spots: FinancialData.trendList.asMap().entries.map((entry) {
                return FlSpot(
                  entry.key.toDouble(),
                  entry.value.expenses,
                );
              }).toList(),
              isCurved: true,
              barWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}