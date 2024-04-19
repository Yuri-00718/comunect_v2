import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashLoadingScreen extends StatefulWidget {
  const SplashLoadingScreen({super.key});

  @override
  State<SplashLoadingScreen> createState() => _SplashLoadingScreenState();
}

class _SplashLoadingScreenState extends State<SplashLoadingScreen> {
  late UserCubit _userCubit;
  
  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    redirectUserToSplashScreenOrDashboard();
    _userCubit.checkUserAuthenticationStatus();
  }

  void redirectUserToSplashScreenOrDashboard() async {

    _userCubit.stream.listen((UserState state) {
      if (state is! AuthenticatedUser) {
        Navigator.pushNamedAndRemoveUntil(context, splash, (route) => false);
      }

      if (state is AuthenticatedUser) {
        Navigator.pushNamedAndRemoveUntil(context, homeScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator(),),
    );
  }
}