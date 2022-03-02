// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_course/Services/location.dart';
import 'package:flutter_course/main.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'nearbymechanic_page.dart';

class NearbyMechanicLoading extends StatefulWidget {
  static const String id = 'NearbyMechanicLoading';
  const NearbyMechanicLoading({Key? key}) : super(key: key);

  @override
  _NearbyMechanicLoadingState createState() => _NearbyMechanicLoadingState();
}

class _NearbyMechanicLoadingState extends State<NearbyMechanicLoading> {
  Location myLocation = Location();
  void loadingData() async {
    await myLocation.getCurrentLocation();
    print('my Lat: ${myLocation.latitude}');
    print('my Long: ${myLocation.longitude}');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NavigatingPage(
            title: 'Nearby Mechanics',
            page: NearbyMechanicPage(
              lat: myLocation.latitude,
              long: myLocation.longitude,
            ),
            floatingButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: fifthLayerColor,
              foregroundColor: Colors.white,
              child: const Icon(
                Icons.center_focus_strong,
                size: 30,
              ),
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
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingFour(
        color: fourthLayerColor,
      ),
    );
  }
}
