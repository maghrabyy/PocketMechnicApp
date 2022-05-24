// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
//import 'package:flutter_course/Components/icon_content.dart';
import 'package:flutter_course/Services/location.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:permission_handler/permission_handler.dart';

/*class GoogleMapServices extends StatefulWidget {
  const GoogleMapServices({Key? key}) : super(key: key);
  @override
  _GoogleMapServicesState createState() => _GoogleMapServicesState();
}

class _GoogleMapServicesState extends State<GoogleMapServices> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geolocator.isLocationServiceEnabled(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == false) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.not_accessible,
                size: 120,
              ),
              const Text(
                'You need to allow access to your location. You can do this by enabling the location on your settings.',
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontFamily: 'Kanit'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const GoogleMapAPI())));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(140, 50)),
                  child: const Text(
                    'Try again',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Geolocator.openLocationSettings();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(140, 50)),
                  child: const Text(
                    'Location Settings',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ],
          );
        } else {
          return FutureBuilder(
            future: Permission.locationWhenInUse.request(),
            builder: (context, AsyncSnapshot<PermissionStatus> status) {
              if (status == PermissionStatus.denied ||
                  status == PermissionStatus.permanentlyDenied) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.not_accessible,
                      size: 120,
                    ),
                    const Text(
                      'You need to allow location\'s permission to allow the application to access your location.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor, fontFamily: 'Kanit'),
                    ),
                    const Text(
                      'Open the app settings to allow location\'s permission,.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor, fontFamily: 'Kanit'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          const GoogleMapAPI();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(140, 50)),
                        child: const Text(
                          'Try again',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          openAppSettings();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(140, 50)),
                        child: const Text(
                          'App Settings',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const GoogleMapAPI();
              }
            },
          );
        }
      },
    );
  }
}
*/
class GoogleMapAPI extends StatefulWidget {
  const GoogleMapAPI({Key? key}) : super(key: key);

  @override
  State<GoogleMapAPI> createState() => _GoogleMapAPIState();
}

class _GoogleMapAPIState extends State<GoogleMapAPI> {
  bool googleMapOn = false;
  GoogleMapController? googleMapController;
  Location myLocation = Location();

  @override
  void dispose() {
    if (googleMapOn == true) {
      googleMapController!.dispose();
      googleMapOn = false;
    }
    super.dispose();
  }

  /*Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    bool isGpsOn = serviceStatus == serviceStatus.isEnabled;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myLocation.getCurrentLocation(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingFour(
                color: fifthLayerColor,
              ),
            );
          } else {
            return GoogleMap(
              mapType: MapType.terrain,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                  target: LatLng(myLocation.latitude, myLocation.longitude),
                  zoom: 15.0),
              onMapCreated: (controller) => googleMapController = controller,
            );
          }
        });
  }
}
