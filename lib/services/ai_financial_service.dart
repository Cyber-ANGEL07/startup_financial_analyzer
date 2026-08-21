import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIFinancialService {
  final String? _apiKey = dotenv.env['GEMINI_API_KEY'];

Future<String?> generateFinancialInsight({
  
  required double revenue,
  required double expenses,
  required double burnRate,
  required double cashRunway,
  required double expenseRatio,
  required double revenueGrowth,
  required String riskLevel,
  required int healthScore,
}) async {
  try {
    if (_apiKey == null || _apiKey!.isEmpty) {
      return 'Gemini API key not found.';
    }

      final url = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent?key=$_apiKey',
      );

    final prompt = '''
    You are an experienced financial consultant specializing in early-stage startup businesses.

    Analyse the financial information below and provide a concise, professional financial assessment.

    Financial Data:
    • Revenue: LKR $revenue
    • Expenses: LKR $expenses
    • Burn Rate: LKR $burnRate
    • Cash Runway: $cashRunway months
    • Expense Ratio: $expenseRatio%
    • Revenue Growth: $revenueGrowth%
    • Risk Level: $riskLevel
    • Health Score: $healthScore/100

    Instructions:
    - Keep the response between 100 and 150 words.
    - Use clear and professional business language.
    - Do not use markdown symbols such as **, ##, or bullet formatting characters that may not display correctly.
    - Structure the response using the following headings:

    Financial Health:
    (Brief assessment)

    Key Risks:
    (List the two or three most important financial concerns.)

    Recommendations:
    (Provide three practical recommendations.)

    Overall Assessment:
    (Conclude with one sentence summarizing the startup's financial outlook.)
    ''';

          final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "contents": [
                {
                  "parts": [
                    {"text": prompt}
                  ]
                }
              ]
            }),
          )
          .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      print('Gemini API Error: ${response.statusCode}');
      print('Gemini API Response: ${response.body}');
      return null;
    }
    } catch (e) {
      print('Gemini Exception: $e');
      return null;
    }
}
}