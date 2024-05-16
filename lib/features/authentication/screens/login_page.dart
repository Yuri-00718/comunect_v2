// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Forms/utils.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    _emailController.text = 'jhbeltran2001@gmail.com';
    _passwordController.text = 'jh09124225209';

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xfff5ebe2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 30 * fem, 20 * fem, 54 * fem),
                width: 39 * fem,
                height: 52 * fem,
                child: Image.asset(
                  'assets/page-1/images/close-window-aA9.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10 * fem),
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      left: 19 * fem,
                      top: 397 * fem,
                      child: Container(
                        width: 389 * fem,
                        height: 204 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15 * fem),
                        ),
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                child: Text(
                                  'Email',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 28 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      16 * fem, 13 * fem, 16 * fem, 12 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc5bbbb),
                                    borderRadius:
                                        BorderRadius.circular(15 * fem),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x3f000000),
                                        offset: Offset(0 * fem, 4 * fem),
                                        blurRadius: 2 * fem,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                  )),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                child: Text(
                                  'Password',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(
                                      16 * fem, 13 * fem, 16 * fem, 12 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffc5bbbb),
                                    borderRadius:
                                        BorderRadius.circular(15 * fem),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x3f000000),
                                        offset: Offset(0 * fem, 4 * fem),
                                        blurRadius: 2 * fem,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0 * fem,
                      top: 80 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 439 * fem,
                          height: 351 * fem,
                          child: Image.asset(
                            'assets/page-1/images/man-sitting-in-a-relaxed-position-with-a-laptop.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.5 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 386 * fem,
                          height: 99 * fem,
                          child: Text(
                            'Capture Moments, Craft Memories: \nYour Personal Note Taking Diary \non the Go!',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w300,
                              height: 1.5 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: signinUser,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 70 * fem,
                    vertical: 20 * fem), // Adjust the vertical margin as needed
                width: double.infinity,
                height: 60 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xff152238),
                  borderRadius: BorderRadius.circular(10 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Log In',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 24 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.5 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signinUser() async {
    await _userCubit.signinUser(
      _emailController.text,
      _passwordController.text,
    );

    if (_userCubit.state is AuthenticatedUser) {
      Navigator.pushNamedAndRemoveUntil(context, homeScreen, (route) => false);
    }
  }
}
