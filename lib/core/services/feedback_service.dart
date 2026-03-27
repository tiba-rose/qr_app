import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Submits guest feedback to a Google Apps Script web app,
/// which appends each submission as a new row in Google Sheets.
///
/// Replace [_scriptUrl] with your deployed Apps Script URL.
class FeedbackService {
  /// Paste your Apps Script deployment URL here.
  static const String _scriptUrl =
      'https://script.google.com/macros/s/AKfycbxZU_DmhgrDOazbl2jbd_kOOyb59AC6LSI6hti5BEXi1k5QOmksBYTEBAaihZ9sqVUY/exec';

  Future<void> submit({
    required String name,
    required String phone,
    required String department,
    required int rating,
    required String message,
  }) async {
    // GET with query parameters avoids CORS preflight issues that occur
    // with POST requests to Google Apps Script on both web and some mobile
    // network configurations. Apps Script exposes these via e.parameter.
    final uri = Uri.parse(_scriptUrl).replace(queryParameters: {
      'name': name,
      'phone': phone,
      'department': department,
      'rating': rating.toString(),
      'message': message,
    });

    debugPrint('Submitting feedback to: $uri');

    final response = await http.get(uri);

    if (response.statusCode < 200 || response.statusCode >= 400) {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}
