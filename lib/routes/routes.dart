import 'package:comunect_v2/features/authentication/screens/login_page.dart';
import 'package:comunect_v2/features/authentication/screens/sign_up_page.dart';
import 'package:comunect_v2/features/find_a_service/screens/post_a_job.dart';
import 'package:comunect_v2/features/home/cubit/service_types_cubit.dart';
import 'package:comunect_v2/features/loading-screens/screens/splash_loading_screen.dart';
import 'package:comunect_v2/features/splash/screens/introduction_animation_screen.dart';
import 'package:comunect_v2/features/home/screens/home_screen.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static final serviceTypesCubit = ServiceTypesCubit();

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
          builder: (context) => Login_Page(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceTypesCubit,
            child: const MyHomePage(),
          ),
        );
      case findAService:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: serviceTypesCubit,
            child: const PostJobScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Text('Invalid URL'),
        );
    }
  }
}
