import 'dart:async';

import 'package:flutter/material.dart';

import '../model/slide_item.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    _startAutoSlide();
  }

  // ── Slider state ────────────────────────────────────────────────────────────

  final PageController pageController = PageController();

  int _currentPage = 0;
  int get currentPage => _currentPage;

  /// Drop images into assets/images/ and list them here.
  /// Any asset that is missing will show a graceful placeholder automatically.
  final List<SlideItem> slides = const [
    SlideItem(assetPath: 'assets/images/hotel_photo_1.jpg'),
    SlideItem(assetPath: 'assets/images/hotel_photo_2.jpg'),
    SlideItem(assetPath: 'assets/images/hotel_photo_3.jpg'),
    SlideItem(assetPath: 'assets/images/hotel_photo_4.jpg'),
    SlideItem(assetPath: 'assets/images/hotel_photo_5.jpg'),
    SlideItem(assetPath: 'assets/images/hotel_photo_6.jpg'),
  ];

  int get slideCount => slides.length;

  // ── Auto-slide ───────────────────────────────────────────────────────────────

  static const Duration _slidePause = Duration(seconds: 4);
  static const Duration _slideAnimation = Duration(milliseconds: 500);

  Timer? _timer;

  void _startAutoSlide() {
    _timer = Timer.periodic(_slidePause, (_) => _advance());
  }

  void _advance() {
    final next = (_currentPage + 1) % slideCount;
    pageController.animateToPage(
      next,
      duration: _slideAnimation,
      curve: Curves.easeInOut,
    );
  }

  /// Called by the PageView whenever the user swipes or the timer fires.
  void onPageChanged(int page) {
    _currentPage = page;
    notifyListeners();
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }
}
