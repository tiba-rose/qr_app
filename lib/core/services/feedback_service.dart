import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Submits guest feedback to a Google Apps Script web app,
/// which appends each submission as a new row in Google Sheets.
///
/// Replace [_scriptUrl] with your deployed Apps Script URL.
class FeedbackService {
  /// Paste your Apps Script deployment URL here.
  static const String _scriptUrl =
      'https://script.google.com/macros/s/AKfycbwjXQKvMmuTyih47EJeZw8kU6jOWiJzrCU_pyqqtU_ecEArsjY-kYkTI9rughito3Wkxw/exec';

  Future<void> submit({
    required String name,
    required String phone,
    required String department,
    required int rating,
    required String message,
  }) async {
    final payload = {
      'name': name,
      'phone': phone,
      'department': department,
      'rating': rating,
      'message': message,
    };

    debugPrint('Submitting feedback: $payload');

    final response = await http.post(
      Uri.parse(_scriptUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    // Google Apps Script redirects POST requests and the final response
    // body may be HTML rather than JSON — so we only check the status code.
    if (response.statusCode < 200 || response.statusCode >= 400) {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}
