import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/onboarding_data.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../home/presentation/main_navigation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final PageController _controller = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [

          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.darkGradient,
            ),
          ),

          // LOTTIE
          Positioned(
            top: 60,
            right: -20,
            child: SizedBox(
              height: 180,
              width: 180,
              child: Lottie.asset(
                'assets/animations/onboarding_flow.json',
                repeat: true,
              ),
            ),
          ),

          // PAGE VIEW
          PageView.builder(
            controller: _controller,

            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainNavigationScreen(),
                ),
              );
            },

            itemCount: onboardingItems.length,

            itemBuilder: (context, index) {

              final item = onboardingItems[index];

              return Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    // IMAGE
                    Container(
                      height: 320,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(35),

                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryRed
                                .withOpacity(0.3),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(35),

                        child: Image.asset(
                          item.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: 0.2),

                    const SizedBox(height: 50),

                    // TITLE
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style:
                      AppTextStyles.headlineMedium,
                    )
                        .animate()
                        .fadeIn(delay: 200.ms),

                    const SizedBox(height: 16),

                    // SUBTITLE
                    Text(
                      item.subtitle,
                      textAlign: TextAlign.center,
                      style:
                      AppTextStyles.bodyMedium,
                    )
                        .animate()
                        .fadeIn(delay: 400.ms),

                    const SizedBox(height: 50),

                    // INDICATORS
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: List.generate(
                        onboardingItems.length,

                            (dotIndex) {

                          return AnimatedContainer(
                            duration:
                            const Duration(
                              milliseconds: 300,
                            ),

                            margin:
                            const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),

                            height: 10,

                            width:
                            currentIndex == dotIndex
                                ? 35
                                : 10,

                            decoration: BoxDecoration(
                              color:
                              currentIndex == dotIndex
                                  ? AppColors.primaryRed
                                  : Colors.white24,

                              borderRadius:
                              BorderRadius.circular(
                                20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 50),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 60,

                      child: ElevatedButton(

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.primaryRed,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        onPressed: () {

                          if (currentIndex ==
                              onboardingItems.length -
                                  1) {

                            // NEXT SCREEN
                          } else {

                            _controller.nextPage(
                              duration:
                              const Duration(
                                milliseconds: 400,
                              ),

                              curve:
                              Curves.easeInOut,
                            );
                          }
                        },

                        child: Text(
                          currentIndex ==
                              onboardingItems.length -
                                  1
                              ? 'Start Watching'
                              : 'Next',

                          style:
                          AppTextStyles.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}