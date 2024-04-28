import 'package:comunect_v2/routes/routes_names.dart';
import 'package:comunect_v2/utils/constants.dart';
import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigation({
  int activePage=0,
  required BuildContext context
}) {
  return BottomNavigationBar(
    currentIndex: activePage,
    items: [
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Services'
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Locals'
      ),
      BottomNavigationBarItem(
        icon: Image.asset('assets/images/job_seeker.png'),
        label: 'Jobs'
      )
    ],
    onTap: (value) {
      if (value == activePage) { return; }

      switch (value) {
        case 0:
          switchTabs(context, homeScreen);
          break;
        case 1:
          switchTabs(context, localChat);
        case 2:
          switchTabs(context, findAJob);
          break;
        default:
      }
    },

  );
}

void switchTabs(context, routeName) {
  Navigator.pushNamedAndRemoveUntil(
    context, 
    routeName, 
    (route) => false
  );
}