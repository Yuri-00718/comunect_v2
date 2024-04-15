import 'package:comunect_v2/Journal_app/feature-journal.dart';
import 'package:comunect_v2/TaskMinder_App/feature-to-do-day-mode.dart';
import 'package:comunect_v2/fitness_app/fitness_app_home_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/Home-list-image/Journal-bg.png',
      navigateScreen: JournalAppHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/Home-list-image/Fitness-bg.png',
      navigateScreen: FitnessAppHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/Home-list-image/TaskMinder-bg.png',
      navigateScreen: TaskminderAppHomeScreen(),
    ),
  ];
}
