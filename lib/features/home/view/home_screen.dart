import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../feedback/view/feedback_modal.dart';
import '../../menu/view/menu_modal.dart';
import '../viewmodel/home_viewmodel.dart';
import 'widgets/action_buttons_widget.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/photo_slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onFeedbackTap() {
    showFeedbackModal(context);
  }

  void _onMenuTap() {
    showMenuModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      // No AppBar — the header widget is part of the body
      body: Column(
        children: [
          const HeaderWidget(),
          const SizedBox(height: 20),
          PhotoSliderWidget(viewModel: _viewModel),
          const SizedBox(height: 24),
          ActionButtonsWidget(
            onFeedbackTap: _onFeedbackTap,
            onMenuTap: _onMenuTap,
          ),
          const Spacer(),
          const FooterWidget(),
        ],
      ),
    );
  }
}
