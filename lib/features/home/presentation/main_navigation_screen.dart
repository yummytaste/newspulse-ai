import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../explore/presentation/explore_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../saved/presentation/saved_screen.dart';
import '../../shorts/presentation/shorts_screen.dart';
import '../../trending/presentation/trending_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int currentIndex = 0;

  final List<Widget> pages = const [
    ShortsScreen(),
    TrendingScreen(),
    ExploreScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.05),
            ),
          ),
        ),

        child: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          backgroundColor: AppColors.surface,

          selectedItemColor: AppColors.primaryRed,
          unselectedItemColor: Colors.white54,

          type: BottomNavigationBarType.fixed,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_fill_rounded),
              label: 'Shorts',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_rounded),
              label: 'Trending',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Explore',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_rounded),
              label: 'Saved',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}