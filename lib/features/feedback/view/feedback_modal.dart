import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../viewmodel/feedback_viewmodel.dart';

export '../viewmodel/feedback_viewmodel.dart' show SubmitState;
import 'widgets/feedback_form_field.dart';
import 'widgets/rating_selector.dart';

void showFeedbackModal(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.55),
    builder: (_) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: const _FeedbackSheet(),
      ),
    ),
  );
}

class _FeedbackSheet extends StatefulWidget {
  const _FeedbackSheet();

  @override
  State<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<_FeedbackSheet> {
  late final FeedbackViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = FeedbackViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(20, 16, 20, bottomPad + 16),
                child: ListenableBuilder(
                  listenable: _viewModel,
                  builder: (context, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SheetHeader(onClose: () => Navigator.of(context).pop()),
                      const SizedBox(height: 20),
                      FeedbackFormField(
                        hintText: AppStrings.feedbackNameHint,
                        prefixIcon: Icons.person_outline_rounded,
                        controller: _viewModel.nameController,
                      ),
                      const SizedBox(height: 10),
                      FeedbackFormField(
                        hintText: AppStrings.feedbackPhoneHint,
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        controller: _viewModel.phoneController,
                      ),
                      const SizedBox(height: 10),
                      _DepartmentDropdown(viewModel: _viewModel),
                      const SizedBox(height: 10),
                      FeedbackFormField(
                        hintText: AppStrings.feedbackMessageHint,
                        prefixIcon: Icons.edit_note_rounded,
                        controller: _viewModel.messageController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      RatingSelector(
                        rating: _viewModel.rating,
                        onRatingChanged: _viewModel.setRating,
                      ),
                      const SizedBox(height: 20),
                      _ActionRow(
                        isLoading: _viewModel.isLoading,
                        onClose: () => Navigator.of(context).pop(),
                        onSend: () async {
                          final error = _viewModel.validate();
                          if (error != null) {
                            _showSnack(context, error, AppColors.maroon);
                            return;
                          }
                          await _viewModel.submitFeedback();
                          if (!context.mounted) return;
                          if (_viewModel.submitState == SubmitState.success) {
                            Navigator.of(context).pop();
                            _showSnack(
                              context,
                              'تم إرسال رأيك بنجاح، شكراً لك!',
                              const Color(0xFF006A71),
                            );
                          } else {
                            _showSnack(
                              context,
                              _viewModel.errorMessage ?? 'حدث خطأ أثناء الإرسال',
                              Colors.red.shade800,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, textDirection: TextDirection.rtl),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.pink, AppColors.pinkDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.pink.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.rate_review_outlined, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                AppStrings.feedbackModalTitle,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                AppStrings.feedbackModalSubtitle,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMid,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onClose,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.goldLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.close_rounded, color: AppColors.maroon, size: 18),
          ),
        ),
      ],
    );
  }
}

// ── Department dropdown ───────────────────────────────────────────────────────

class _DepartmentDropdown extends StatelessWidget {
  const _DepartmentDropdown({required this.viewModel});

  final FeedbackViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: viewModel.selectedDepartmentId,
      isExpanded: true,
      dropdownColor: AppColors.cardBg,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.gold),
      decoration: InputDecoration(
        hintText: AppStrings.feedbackDepartmentHint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          color: AppColors.textLight,
          fontSize: 14,
        ),
        filled: true,
        fillColor: AppColors.fieldBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIcon: const Icon(Icons.apartment_rounded, color: AppColors.gold, size: 20),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(color: AppColors.fieldBorderFocus, width: 1.5),
      ),
      items: viewModel.departments
          .map(
            (d) => DropdownMenuItem<String>(
              value: d.id,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  d.name,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      onChanged: viewModel.selectDepartment,
    );
  }

  OutlineInputBorder _border({Color color = AppColors.fieldBorder, double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

// ── Action row ────────────────────────────────────────────────────────────────

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.isLoading,
    required this.onSend,
    required this.onClose,
  });

  final bool isLoading;
  final VoidCallback onSend;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _GradientButton(isLoading: isLoading, onPressed: onSend),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: OutlinedButton(
            onPressed: onClose,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.maroon,
              side: const BorderSide(color: AppColors.goldBorder, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              AppStrings.feedbackClose,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLoading
                  ? [AppColors.pink.withOpacity(0.5), AppColors.pinkDark.withOpacity(0.5)]
                  : const [AppColors.pink, AppColors.pinkDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: isLoading
                ? []
                : [
                    BoxShadow(
                      color: AppColors.pink.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text(
                    AppStrings.feedbackSend,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
