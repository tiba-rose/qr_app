import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class RatingSelector extends StatelessWidget {
  const RatingSelector({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.fieldBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.fieldBorder, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final star = index + 1;
          final active = star <= rating;
          return GestureDetector(
            onTap: () => onRatingChanged(star),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                active ? Icons.star_rounded : Icons.star_outline_rounded,
                key: ValueKey(active),
                color: active ? AppColors.gold : AppColors.fieldBorder,
                size: 36,
              ),
            ),
          );
        }),
      ),
    );
  }
}
