import 'package:flutter/material.dart';

class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  Color _getIconColor() {
    if (title.contains('Revenue')) {
      return Colors.green;
    } else if (title.contains('Expenses')) {
      return Colors.red;
    } else if (title.contains('Profit')) {
      return Colors.teal;
    } else if (title.contains('Burn Rate')) {
      return Colors.orange;
    } else if (title.contains('Cash Runway')) {
      return Colors.blue;
    } else if (title.contains('Health')) {
      return Colors.pink;
    } else if (title.contains('Forecast')) {
      return Colors.purple;
    } else if (title.contains('Growth')) {
      return Colors.indigo;
    } else if (title.contains('Expense Ratio')) {
      return Colors.amber.shade800;
    }

    return Colors.blue;
  }


@override
Widget build(BuildContext context) {
  final iconColor = _getIconColor();

  Color valueColor = Theme.of(context).colorScheme.onSurface;

  if (title.contains('Profit / Loss')) {
    final number = double.tryParse(
      value.replaceAll('LKR ', '').replaceAll(',', ''),
    );

    if (number != null) {
      valueColor = number >= 0
          ? Colors.green
          : Colors.red;
    }
  }

  return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 28,
                color: iconColor,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: valueColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}