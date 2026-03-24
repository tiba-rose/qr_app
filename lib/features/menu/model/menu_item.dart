import 'package:flutter/material.dart';

/// Represents a single restaurant/service menu entry in the menu list.
class MenuItem {
  const MenuItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.url,
  });

  final String name;
  final IconData icon;
  final Color color;

  /// The URL that opens when the user taps this item.
  final String url;
}
