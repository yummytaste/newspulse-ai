import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../models/firebase_short_model.dart';
import '../../../services/shorts_service.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() =>
      _ShortsScreenState();
}

class _ShortsScreenState
    extends State<ShortsScreen> {

  final ShortsService shortsService =
  ShortsService();

  final PageController pageController =
  PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppColors.background,

      body: StreamBuilder<
          List<FirebaseShortModel>>(

        stream: shortsService.getShorts(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(
                color:
                AppColors.primaryRed,
              ),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                'Something went wrong',
                style:
                AppTextStyles.bodyLarge,
              ),
            );
          }

          final shorts = snapshot.data ?? [];

          if (shorts.isEmpty) {

            return Center(
              child: Text(
                'No shorts available',
                style:
                AppTextStyles.bodyLarge,
              ),
            );
          }

          return PageView.builder(

            controller: pageController,

            scrollDirection: Axis.vertical,

            onPageChanged: (index) {

              setState(() {
                currentIndex = index;
              });
            },

            itemCount: shorts.length,

            itemBuilder: (context, index) {

              final short =
              shorts[index];

              return FirebaseVideoItem(

                key: ValueKey(short.id),

                short: short,

                isActive:
                currentIndex == index,
              );
            },
          );
        },
      ),
    );
  }
}

class FirebaseVideoItem
    extends StatefulWidget {

  final FirebaseShortModel short;

  final bool isActive;

  const FirebaseVideoItem({
    super.key,
    required this.short,
    required this.isActive,
  });

  @override
  State<FirebaseVideoItem> createState() =>
      _FirebaseVideoItemState();
}

class _FirebaseVideoItemState
    extends State<FirebaseVideoItem> {

  late VideoPlayerController controller;

  final ShortsService shortsService =
  ShortsService();

  bool isMuted = false;

  bool viewAdded = false;

  @override
  void initState() {
    super.initState();

    controller =
    VideoPlayerController.networkUrl(
      Uri.parse(
        widget.short.videoUrl,
      ),
    )

      ..initialize().then((_) {

        controller.setLooping(true);

        if (widget.isActive) {

          controller.play();

          addView();
        }

        setState(() {});
      });
  }

  void addView() {

    if (!viewAdded) {

      viewAdded = true;

      shortsService.increaseView(
        widget.short.id,
      );
    }
  }

  @override
  void didUpdateWidget(
      covariant FirebaseVideoItem
      oldWidget) {

    super.didUpdateWidget(oldWidget);

    if (widget.isActive) {

      controller.play();

      addView();

    } else {

      controller.pause();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!controller.value.isInitialized) {

      return const Center(
        child: CircularProgressIndicator(
          color:
          AppColors.primaryRed,
        ),
      );
    }

    return GestureDetector(

      onTap: () {

        if (controller
            .value.isPlaying) {

          controller.pause();

        } else {

          controller.play();
        }

        setState(() {});
      },

      onLongPress: () {

        isMuted = !isMuted;

        controller.setVolume(
          isMuted ? 0 : 1,
        );

        setState(() {});
      },

      child: Stack(
        fit: StackFit.expand,

        children: [

          // VIDEO
          FittedBox(
            fit: BoxFit.cover,

            child: SizedBox(
              width:
              controller.value.size.width,

              height:
              controller.value.size.height,

              child:
              VideoPlayer(controller),
            ),
          ),

          // OVERLAY
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [

                  Colors.transparent,

                  Colors.black.withOpacity(
                    0.78,
                  ),
                ],

                begin: Alignment.topCenter,
                end:
                Alignment.bottomCenter,
              ),
            ),
          ),

          // TOP BAR
          SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

                children: [

                  Text(
                    'NewsPulse',
                    style:
                    AppTextStyles
                        .titleLarge,
                  ),

                  Icon(
                    isMuted
                        ? Icons.volume_off
                        : Icons.volume_up,

                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          // CONTENT
          Positioned(
            left: 20,
            right: 20,
            bottom: 40,

            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.end,

              children: [

                // LEFT
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    mainAxisSize:
                    MainAxisSize.min,

                    children: [

                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration:
                        BoxDecoration(
                          color: AppColors
                              .primaryRed,

                          borderRadius:
                          BorderRadius
                              .circular(
                            30,
                          ),
                        ),

                        child: Text(
                          widget.short
                              .category,

                          style:
                          AppTextStyles
                              .caption,
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      Text(
                        widget.short.title,

                        style:
                        AppTextStyles
                            .headlineMedium,
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Text(
                        widget.short
                            .description,

                        style:
                        AppTextStyles
                            .bodyMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 20,
                ),

                // RIGHT ACTIONS
                Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [

                    actionButton(
                      icon: Icons.favorite,
                      text: widget.short.likes
                          .toString(),

                      onTap: () {

                        shortsService
                            .increaseLike(
                          widget.short.id,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    actionButton(
                      icon: Icons.share,
                      text: widget.short
                          .shares
                          .toString(),

                      onTap: () {

                        shortsService
                            .increaseShare(
                          widget.short.id,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    actionButton(
                      icon:
                      Icons.remove_red_eye,

                      text: widget.short.views
                          .toString(),

                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Column(
        children: [

          CircleAvatar(
            radius: 26,

            backgroundColor:
            Colors.black.withOpacity(
              0.4,
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            text,
            style:
            AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}