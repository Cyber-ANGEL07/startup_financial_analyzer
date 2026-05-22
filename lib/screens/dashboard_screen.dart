import 'package:flutter/material.dart';
import '../widgets/kpi_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Startup Financial Overview',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            KpiCard(
              title: 'Monthly Revenue',
              value: 'LKR 0',
              icon: Icons.trending_up,
            ),
            KpiCard(
              title: 'Monthly Expenses',
              value: 'LKR 0',
              icon: Icons.money_off,
            ),
            KpiCard(
              title: 'Burn Rate',
              value: 'LKR 0',
              icon: Icons.local_fire_department,
            ),
            KpiCard(
              title: 'Cash Runway',
              value: '0 months',
              icon: Icons.timeline,
            ),
          ],
        ),
      ),
    );
  }
}