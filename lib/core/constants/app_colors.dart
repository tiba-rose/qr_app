import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Brand palette ─────────────────────────────────────────────────────────
  static const Color lightest   = Color(0xFFF2EFE7); // warm cream
  static const Color lightTeal  = Color(0xFF9ACBD0); // light teal
  static const Color midTeal    = Color(0xFF48A6A7); // medium teal
  static const Color darkTeal   = Color(0xFF006A71); // deep teal
  static const Color deepestTeal = Color(0xFF004349); // extra dark (derived)

  // ── Screen background ─────────────────────────────────────────────────────
  static const Color background = lightest;

  // ── Header gradient ───────────────────────────────────────────────────────
  static const Color headerTop    = darkTeal;
  static const Color headerBottom = deepestTeal;

  // ── Maroon aliases → now deep teal ───────────────────────────────────────
  static const Color maroon     = darkTeal;
  static const Color maroonDark = deepestTeal;

  // ── Action buttons ────────────────────────────────────────────────────────
  static const Color pink     = darkTeal;    // feedback button top
  static const Color pinkDark = deepestTeal; // feedback button bottom
  static const Color teal     = midTeal;     // menu button top
  static const Color tealDark = darkTeal;    // menu button bottom

  // ── Gold → now light teal ────────────────────────────────────────────────
  static const Color gold       = lightTeal;
  static const Color goldBright = midTeal;
  static const Color goldLight  = Color(0xFFDCF0F2); // very light teal
  static const Color goldBorder = Color(0xFFB3DDE0); // muted light teal

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textDark   = Color(0xFF002B2E); // near-black teal
  static const Color textMid    = darkTeal;
  static const Color textLight  = lightTeal;
  static const Color footerText = lightTeal;

  // ── Slider ────────────────────────────────────────────────────────────────
  static const Color sliderPlaceholder     = Color(0xFFD5EEF0);
  static const Color sliderPlaceholderIcon = lightTeal;
  static const Color dotActive             = Colors.white;
  static const Color dotInactive           = Color(0x44FFFFFF);

  // ── Form fields ───────────────────────────────────────────────────────────
  static const Color fieldBg          = lightest;
  static const Color fieldBorder      = Color(0xFFB3DDE0);
  static const Color fieldBorderFocus = darkTeal;

  // ── Card / surface ────────────────────────────────────────────────────────
  static const Color cardBg  = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFD5EEF0);
}
