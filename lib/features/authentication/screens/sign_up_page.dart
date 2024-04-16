// ignore_for_file: use_build_context_synchronously

import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Forms/utils.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();
  String? _passwordDoesNotMatched;
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

    return Material(child: BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        bool credentialsIsValid = state is! UserCredentialsNotValid;
        
        return SingleChildScrollView(
            child: Form(
              key: _signupFormKey,
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xfff5ebe2),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Header and Images
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Navigate back when tapped
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 9 * fem, 23 * fem),
                            width: 39 * fem,
                            height: 92 * fem,
                            child: Image.asset(
                              'assets/page-1/images/close-window.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 14 * fem, 48 * fem),
                          width: 402 * fem,
                          height: 150 * fem,
                          child: Image.asset(
                            'assets/page-1/images/kids.png',
                            fit: BoxFit.contain,
                          ),
                        ),
              
                        // Form
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              13 * fem, 0 * fem, 14 * fem, 81 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Email or Phone
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                    children: const [
                                      TextSpan(text: 'Email'),
                                    ],
                                  ),
                                ),
                              ),
              
                              // Email
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffc5bbbb),
                                  borderRadius: BorderRadius.circular(
                                      8 * fem), // Adjust the radius
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
                                  decoration: InputDecoration(
                                    errorText: getEmailFieldErrorMessage(credentialsIsValid),
                                    hintText: 'Type Here...',
                                    hintStyle: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xff7e7272),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
              
                              // Password
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 11 * fem),
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
              
                              // Password Input
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffc5bbbb),
                                  borderRadius: BorderRadius.circular(
                                      8 * fem), // Adjusted the radius
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
                                  decoration: InputDecoration(
                                    errorText: getPasswordErrorMessage(credentialsIsValid),
                                    hintText: 'Type Here...',
                                    hintStyle: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xff7e7272),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
              
                              // Confirm Password
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 11 * fem),
                                child: RichText(
                                  text: TextSpan(
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xffffffff),
                                    ),
                                    children: [
                                      const TextSpan(text: ''),
                                      const TextSpan(text: ''),
                                      TextSpan(
                                        text: 'Confirm Password',
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 20 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5 * ffem / fem,
                                          color: const Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
              
                              // Confirm Password Input
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 11 * fem),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffc5bbbb),
                                  borderRadius: BorderRadius.circular(
                                      8 * fem), // Adjusted the radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x3f000000),
                                      offset: Offset(0 * fem, 4 * fem),
                                      blurRadius: 2 * fem,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  onChanged: validateConfirmPassword,
                                  validator: validateConfirmPassword,
                                  decoration: InputDecoration(
                                    hintText: 'Type Here...',
                                    errorText: _passwordDoesNotMatched,
                                    hintStyle: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xff7e7272),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
              
                              // User Name
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                child: Text(
                                  'User Name',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
              
                              // User Name Input
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 11 * fem),
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffc5bbbb),
                                  borderRadius: BorderRadius.circular(
                                      8 * fem), // Adjusted the radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x3f000000),
                                      offset: Offset(0 * fem, 4 * fem),
                                      blurRadius: 2 * fem,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Type Here...',
                                    hintStyle: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * ffem / fem,
                                      color: const Color(0xff7e7272),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8 * fem), // Adjust the radius
                                      borderSide: const BorderSide(
                                        color: Color(0xffc5bbbb),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
              
                              // Log In Button
                              GestureDetector(
                                onTap: signupUser,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      64 * fem, 0 * fem, 65 * fem, 100 * fem),
                                  width: double.infinity,
                                  height: 56 * fem,
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
                      ])),
            ));
      },
    ));
  }

  String? validateConfirmPassword(String? value) {
    if (value == _passwordController.text) {
      setState(() => _passwordDoesNotMatched = null);
      return null;
    }
    setState(() => _passwordDoesNotMatched = 'Password does not matched.');
    return 'Password does not matched.';
  }

  String? getEmailFieldErrorMessage(bool credentialsIsValid) {
    if (credentialsIsValid) {
      return null;
    }

    var state = _userCubit.state as UserCredentialsNotValid;

    if (state.emailAlreadyExists) {
      return 'Email is already taken!';
    }

    if (state.invalidEmail) {
      return 'Invalid email';
    }
    return null;
  }

  String? getPasswordErrorMessage(bool credentialsIsValid) {
    if (credentialsIsValid) {
      return null;
    }

    var state = _userCubit.state as UserCredentialsNotValid;

    if (state.passwordIsWeak) {
      return 'Password is weak';
    }

    return null;
  }

  void signupUser() async {
    bool isValid = _signupFormKey.currentState!.validate();

    if (!isValid) { return; }

    await _userCubit.createNewUser(
      _emailController.text,
      _passwordController.text,
      _usernameController.text,
    );

    if (_userCubit.state is UserIsCreated) {
      Navigator.pushNamedAndRemoveUntil(
        context, 
        signin, 
        (route) => false
      );
    }
  }
}
