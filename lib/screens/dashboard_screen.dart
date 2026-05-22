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

            SizedBox(height: 24),

            Text(
              'Risk Assessment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Card(
              color: Colors.orange,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color:Colors.white,
                    ),

                    SizedBox(width: 12),
                    Expanded(child: 
                    Text(
                      'Medium Financial Risk Detected',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}