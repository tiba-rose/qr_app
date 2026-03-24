import 'package:flutter/material.dart';

import '../../../core/services/feedback_service.dart';
import '../model/feedback_department.dart';

enum SubmitState { idle, loading, success, error }

class FeedbackViewModel extends ChangeNotifier {
  FeedbackViewModel() : _service = FeedbackService();

  final FeedbackService _service;

  // ── Form controllers ─────────────────────────────────────────────────────

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // ── Department ───────────────────────────────────────────────────────────

  final List<FeedbackDepartment> departments = const [
    FeedbackDepartment(id: 'الأغذية والمشروبات', name: 'الأغذية والمشروبات'),
    FeedbackDepartment(id: 'الأنشطة', name: 'الأنشطة'),
    FeedbackDepartment(id: 'الإسكان', name: 'الإسكان'),
    FeedbackDepartment(id: 'الحفلات والمناسبات', name: 'الحفلات والمناسبات'),
  ];

  String? _selectedDepartmentId;
  String? get selectedDepartmentId => _selectedDepartmentId;

  void selectDepartment(String? value) {
    _selectedDepartmentId = value;
    notifyListeners();
  }

  // ── Rating ───────────────────────────────────────────────────────────────

  int _rating = 1;
  int get rating => _rating;

  void setRating(int value) {
    _rating = value;
    notifyListeners();
  }

  // ── Submit state ─────────────────────────────────────────────────────────

  SubmitState _submitState = SubmitState.idle;
  SubmitState get submitState => _submitState;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _submitState == SubmitState.loading;

  // ── Validation ───────────────────────────────────────────────────────────

  /// Returns an Arabic error string if any required field is missing.
  String? validate() {
    if (nameController.text.trim().isEmpty) return 'يرجى إدخال الاسم';
    if (phoneController.text.trim().isEmpty) return 'يرجى إدخال رقم الهاتف';
    if (_selectedDepartmentId == null) return 'يرجى اختيار القسم';
    return null;
  }

  // ── Submit ───────────────────────────────────────────────────────────────

  Future<void> submitFeedback() async {
    _submitState = SubmitState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.submit(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        department: _selectedDepartmentId ?? '',
        rating: _rating,
        message: messageController.text.trim(),
      );
      _submitState = SubmitState.success;
    } catch (e) {
      _submitState = SubmitState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
