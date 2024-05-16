/* 
  Authored by: John Harold M. Beltran
  Company:  Team John's + R 
  Project: CommunityConnect
  Feature: [COM - 002] Home Page
  Description: The first screen that the user see after login and the list 
  of services that are available.
 */
// ignore_for_file: use_build_context_synchronously

import 'package:comunect_v2/app_theme.dart';
import 'package:comunect_v2/common/widgets/bottom_navigation.dart';
import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/features/find_a_service/repositories/service_type_repo.dart';
import 'package:comunect_v2/features/find_a_service/models/service_type.dart';
import 'package:comunect_v2/features/home/cubit/service_types_cubit.dart';
import 'package:comunect_v2/features/home/utils/ask_permission_for_location_access.dart';
import 'package:comunect_v2/routes/routes.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/homelist.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;
  late UserCubit _userCubit;
  late ServiceTypesCubit _serviceTypeCubit;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    _userCubit = context.read<UserCubit>();
    _serviceTypeCubit = context.read<ServiceTypesCubit>();
    loadInitialData();
    loadServiceTypes();
    askPermissionForLocationAccess();
  }

  void loadInitialData() async {
    await ServiceTypeRepository().addInitialData();
  }

  void loadServiceTypes() async {
    await _serviceTypeCubit.loadServiceTypes();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? const Color(0xFFF5EBE2) : AppTheme.nearlyBlack,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _userCubit.signOutUser();
          Navigator.pushNamedAndRemoveUntil(context, signin, (route) => false);
        },
        child: const Icon(Icons.logout),
      ),
      bottomNavigationBar: bottomNavigation(context: context),
      body: body(),
    );
  }

  Widget body() {
    return BlocBuilder<ServiceTypesCubit, ServiceTypesState>(
        builder: (context, state) {
      if (state is ServiceTypesLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      state = state as ServiceTypesLoaded;

      List<ServiceType> serviceTypes = state.serviceTypes;

      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBar(),
            Expanded(
                child: GridView(
              padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: multiple ? 2 : 1,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 1.5,
              ),
              children: List<Widget>.generate(
                serviceTypes.length,
                (int index) {
                  final int count = serviceTypes.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  return HomeListView(
                    animation: animation,
                    animationController: animationController,
                    listData: serviceTypes[index],
                    callBack: () {
                      _serviceTypeCubit.selectServiceType(index);
                      Navigator.pushNamed(context, findAService);
                    },
                  );
                },
              ),
            )),
          ],
        ),
      );
    });
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Column(
      children: [
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: SizedBox(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'COMMUNECT',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                        color: isLightMode ? AppTheme.darkText : AppTheme.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  color: isLightMode
                      ? const Color(0xFFF5EBE2)
                      : AppTheme.nearlyBlack,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: Icon(
                        multiple ? Icons.dashboard : Icons.view_agenda,
                        color:
                            isLightMode ? AppTheme.dark_grey : AppTheme.white,
                      ),
                      onTap: () {
                        setState(() {
                          multiple = !multiple;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 8, top: 16, bottom: 16), // Adjusted padding
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'What are you looking for?', // Text before the search bar
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18, // Adjust font size as needed
                    fontWeight: FontWeight.w600,
                    color: Colors.black87, // Adjust color as needed
                  ),
                ),
                const SizedBox(
                    height: 12), // Increased space between text and search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search a service',
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15, // Reduced font size
                      fontWeight: FontWeight.w600,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Border radius 20
                      borderSide: BorderSide.none, // Remove border
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(
                        118, 118, 118, 0.5), // Slightly faded color
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(
                          right:
                              8), // Padding only to the right side of the icon
                      child: Icon(Icons.search, size: 28), // Increase icon size
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 24, // Reduced size
                      minWidth: 24, // Reduced size
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16), // Adjust content padding
                  ),
                  // Implement your search functionality here
                ),
                const SizedBox(
                    height:
                        16), // Increased space between search bar and content below
                // Add your content below the search bar
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {super.key,
      required this.listData,
      this.callBack,
      this.animationController,
      this.animation});

  final ServiceType listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        color: const Color(0xFF5DEBD7),
                        width: 60, // Set your desired width
                        height: 60, // Set your desired height
                        child: Row(
                          children: [
                            Image.network(
                              '${listData.imageUrl}',
                              fit: BoxFit.contain, // or BoxFit.fitHeight
                            ),
                            Text(listData.name)
                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
