import 'package:comunect_v2/Report_screen.dart';
import 'package:comunect_v2/app_theme.dart';
import 'package:comunect_v2/custom_drawer/drawer_user_controller.dart';
import 'package:comunect_v2/custom_drawer/home_drawer.dart';
import 'package:comunect_v2/feedback_screen.dart';
import 'package:comunect_v2/help_screen.dart';
import 'package:comunect_v2/features/home/screens/home_screen.dart';
import 'package:comunect_v2/invite_friend_screen.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = const HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = const FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = const InviteFriend();
          });
          break;
        case DrawerIndex.Report:
          setState(() {
            screenView = const ReportScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = const FeedbackScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
