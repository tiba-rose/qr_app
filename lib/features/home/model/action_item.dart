import 'package:flutter/material.dart';

/// Represents one of the action buttons on the home screen.
class ActionItem {
  const ActionItem({
    required this.color,
    required this.icon,
    required this.arabicLabel,
    required this.englishLabel,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final String arabicLabel;
  final String englishLabel;
  final VoidCallback onTap;
}
