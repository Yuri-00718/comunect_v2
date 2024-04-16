import 'package:comunect_v2/features/authentication/screens/login_page.dart';
import 'package:comunect_v2/features/authentication/screens/sign_up_page.dart';
import 'package:comunect_v2/features/loading-screens/screens/splash_loading_screen.dart';
import 'package:comunect_v2/features/splash/screens/introduction_animation_screen.dart';
import 'package:comunect_v2/features/home/screens/home_screen.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  static MaterialPageRoute generateRoute(RouteSettings onGenerateRoutes) {
    switch (onGenerateRoutes.name) {
      case splashLoadingScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashLoadingScreen(),
        );
      case splash:
        return MaterialPageRoute(
          builder: (context) => const IntroductionAnimationScreen(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (context) => const Signup(),
        );
      case signin:
        return MaterialPageRoute(
          builder:(context) => const Login_Page(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder:(context) => const MyHomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Text('Invalid URL'),
        );
    }
  }
}
