import 'dart:ffi';

import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/features/authentication/screens/noted-sign-in-page.dart';
import 'package:comunect_v2/features/loading-screens/screens/splash_loading_screen.dart';
import 'package:comunect_v2/features/splash/screens/introduction_animation_screen.dart';
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
            child: SplashLoadingScreen(),
          ),
        );
      case splash:
        return MaterialPageRoute(
          builder: (context) => IntroductionAnimationScreen(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (context) => Signup(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Text('Invalid URL'),
        );
    }
  }
}
