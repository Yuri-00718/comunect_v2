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
      imagePath: 'assets/Home-list-image/serviceman_with_beard.png',
    ),
    HomeList(
      imagePath: 'assets/Home-list-image/Fitness-bg.png',
    ),
    HomeList(
      imagePath: 'assets/Home-list-image/TaskMinder-bg.png',
    ),
  ];
}
