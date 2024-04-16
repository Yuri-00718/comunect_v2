import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/features/authentication/screens/login_page.dart';
import 'package:comunect_v2/features/authentication/screens/sign_up_page.dart';
import 'package:comunect_v2/features/loading-screens/screens/splash_loading_screen.dart';
import 'package:comunect_v2/features/splash/screens/introduction_animation_screen.dart';
import 'package:comunect_v2/home_screen.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static var userCubit = UserCubit();

  static MaterialPageRoute generateRoute(RouteSettings onGenerateRoutes) {
    switch (onGenerateRoutes.name) {
      case splashLoadingScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: userCubit,
            child: const SplashLoadingScreen(),
          ),
        );
      case splash:
        return MaterialPageRoute(
          builder: (context) => const IntroductionAnimationScreen(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: userCubit,
            child: const Signup(),
          ),
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
