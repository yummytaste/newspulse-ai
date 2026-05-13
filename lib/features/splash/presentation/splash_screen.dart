import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../onboarding/presentation/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.darkGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryRed.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 70,
              ),
            )
                .animate()
                .scale(
              duration: 900.ms,
              curve: Curves.easeOutBack,
            ),

            const SizedBox(height: 30),

            Text(
              AppConstants.appName,
              style: AppTextStyles.headlineLarge,
            )
                .animate()
                .fadeIn(duration: 700.ms)
                .slideY(begin: 0.3),

            const SizedBox(height: 12),

            Text(
              AppConstants.tagline,
              style: AppTextStyles.bodyMedium,
            )
                .animate()
                .fadeIn(delay: 300.ms),

            const SizedBox(height: 60),

            const CircularProgressIndicator(
              color: AppColors.primaryRed,
            ),
          ],
        ),
      ),
    );
  }
}