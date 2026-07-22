import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/financial_data.dart';

class PdfReportService {
  static Future<void> generateFinancialReport() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Startup Financial Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Revenue: LKR ${FinancialData.revenue.toStringAsFixed(2)}'),
              pw.Text('Forecast Revenue: LKR ${FinancialData.forecastRevenue.toStringAsFixed(2)}'),
              pw.Text('Expenses: LKR ${FinancialData.expenses.toStringAsFixed(2)}'),
              pw.Text('Profit / Loss: LKR ${FinancialData.profitLoss.toStringAsFixed(2)}'),
              pw.Text('Expense Ratio: ${FinancialData.expenseRatio.toStringAsFixed(1)}%',),
              pw.Text('Revenue Growth: ${FinancialData.revenueGrowth.toStringAsFixed(1)}%',),
              pw.Text('Burn Rate: LKR ${FinancialData.burnRate.toStringAsFixed(2)}'),
              pw.Text('Cash Runway: ${FinancialData.cashRunway.toStringAsFixed(1)} months'),
              pw.Text('Risk Level: ${FinancialData.riskLevel}'),
              pw.Text('Health Score: ${FinancialData.healthScore}/100'),
              pw.Text('Startup Status: ${FinancialData.startupStatus}'),
              pw.SizedBox(height: 20),
              pw.Text(
                'Recommendation',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(FinancialData.recommendation),
              pw.SizedBox(height: 20),

              pw.Text(
                'Financial Insight',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.Text(FinancialData.aiInsight),
            ],
          ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}