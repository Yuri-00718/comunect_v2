

import 'package:comunect_v2/utils/globals.dart';
import 'package:permission_handler/permission_handler.dart';

void askPermissionForLocationAccess() async {
  locationPermissionStatus = await Permission.location.status;

  if (!locationPermissionStatus!.isGranted) {
    locationPermissionStatus = await Permission.location.request();
  }
}