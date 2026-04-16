import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../model/slide_item.dart';
import '../../viewmodel/home_viewmodel.dart';

class PhotoSliderWidget extends StatelessWidget {
  const PhotoSliderWidget({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final sliderH = (screenH * 0.28).clamp(180.0, 320.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x2A000000),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            height: sliderH,
            child: Stack(
              children: [
                PageView.builder(
                  controller: viewModel.pageController,
                  onPageChanged: viewModel.onPageChanged,
                  itemCount: viewModel.slideCount,
                  itemBuilder: (_, index) =>
                      _SlideImage(slide: viewModel.slides[index]),
                ),
                // Bottom gradient
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0x66000000)],
                          stops: [0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                // Dot indicators
                Positioned(
                  bottom: 14,
                  left: 0,
                  right: 0,
                  child: ListenableBuilder(
                    listenable: viewModel,
                    builder: (_, __) => _DotIndicator(
                      count: viewModel.slideCount,
                      activeIndex: viewModel.currentPage,
                    ),
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

class _SlideImage extends StatelessWidget {
  const _SlideImage({required this.slide});

  final SlideItem slide;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      slide.assetPath,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const _Placeholder(),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sliderPlaceholder,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 52, color: AppColors.sliderPlaceholderIcon),
          SizedBox(height: 8),
          Text(
            'Hotel Photo',
            style: TextStyle(
              color: AppColors.sliderPlaceholderIcon,
              fontSize: 13,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: i == activeIndex ? 24 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: i == activeIndex ? Colors.white : AppColors.dotInactive,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
