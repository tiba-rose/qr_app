import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../model/action_item.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({
    super.key,
    required this.onFeedbackTap,
    required this.onMenuTap,
  });

  final VoidCallback onFeedbackTap;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _WideActionCard(
            item: ActionItem(
              color: AppColors.pink,
              icon: Icons.rate_review_outlined,
              arabicLabel: AppStrings.feedbackArabic,
              englishLabel: AppStrings.feedbackEnglish,
              onTap: onFeedbackTap,
            ),
            gradientColors: const [Color(0xFF006A71), Color(0xFF004349)],
            iconBg: const Color(0x22FFFFFF),
          ),
          const SizedBox(height: 14),
          _WideActionCard(
            item: ActionItem(
              color: AppColors.teal,
              icon: Icons.menu_book_outlined,
              arabicLabel: AppStrings.menuArabic,
              englishLabel: AppStrings.menuEnglish,
              onTap: onMenuTap,
            ),
            gradientColors: const [Color(0xFF48A6A7), Color(0xFF006A71)],
            iconBg: const Color(0x22FFFFFF),
          ),
        ],
      ),
    );
  }
}

class _WideActionCard extends StatelessWidget {
  const _WideActionCard({
    required this.item,
    required this.gradientColors,
    required this.iconBg,
  });

  final ActionItem item;
  final List<Color> gradientColors;
  final Color iconBg;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          height: (MediaQuery.of(context).size.height * 0.1).clamp(72.0, 96.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors.first.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1,
                    ),
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 18),
                // Labels
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.arabicLabel,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (MediaQuery.of(context).size.width * 0.044).clamp(14.0, 19.0),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.englishLabel,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: (MediaQuery.of(context).size.width * 0.032).clamp(11.0, 15.0),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
