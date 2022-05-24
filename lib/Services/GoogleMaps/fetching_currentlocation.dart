// ignore_for_file: avoid_print

/*import 'package:flutter/material.dart';
import 'package:flutter_course/Services/location.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'googlemapsservice.dart';

class FetchCurrentLocation extends StatefulWidget {
  const FetchCurrentLocation({
    Key? key,
    required this.pageTitle,
  }) : super(key: key);
  final String pageTitle;
  @override
  _FetchCurrentLocationState createState() => _FetchCurrentLocationState();
}

class _FetchCurrentLocationState extends State<FetchCurrentLocation> {
  bool isPopAllowed = false;
  Location myLocation = Location();
  void loadingData() async {
    await myLocation.getCurrentLocation();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NavigatingPage(
            title: widget.pageTitle,
            page: GoogleMapServices(
              pageTitle: widget.pageTitle,
              lat: myLocation.latitude,
              long: myLocation.longitude,
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isPopAllowed) {
          return true; // allows pop
        }
        return false; // prevents pop
      },
      child: const Scaffold(
        body: Center(
          child: SpinKitFadingFour(
            color: fourthLayerColor,
          ),
        ),
      ),
    );
  }
}
*/