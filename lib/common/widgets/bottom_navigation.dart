import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigation() {
  return BottomNavigationBar(
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
        label: 'Locals'
      )
    ],
    onTap: (value) {
      if (value == 0) { 

      }
    },
  );
}