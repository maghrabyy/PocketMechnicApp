// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_course/Services/GoogleMaps/fetching_currentlocation.dart';
import 'package:flutter_course/Services/location.dart';
import 'package:flutter_course/style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapServices extends StatefulWidget {
  static const String id = 'GoogleMapServices';
  final double lat;
  final double long;
  final String pageTitle;
  const GoogleMapServices(
      {Key? key,
      required this.lat,
      required this.long,
      required this.pageTitle})
      : super(key: key);
  @override
  _GoogleMapServicesState createState() => _GoogleMapServicesState();
}

class _GoogleMapServicesState extends State<GoogleMapServices> {
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
                            builder: (context) => FetchCurrentLocation(
                                pageTitle: widget.pageTitle)));
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
          if (widget.lat == 0 && widget.long == 0) {
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FetchCurrentLocation(
                                  pageTitle: widget.pageTitle)));
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
            googleMapOn = true;
            return GoogleMap(
              mapType: MapType.terrain,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long), zoom: 15.0),
              onMapCreated: (controller) => googleMapController = controller,
            );
          }
        }
      },
    );
  }
}
