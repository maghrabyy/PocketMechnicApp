import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../main.dart';
import 'nearbymechanic_page.dart';

class NearbyMechanicLoading extends StatefulWidget {
  const NearbyMechanicLoading({Key? key}) : super(key: key);

  @override
  _NearbyMechanicLoadingState createState() => _NearbyMechanicLoadingState();
}

class _NearbyMechanicLoadingState extends State<NearbyMechanicLoading> {
  void loadingData() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigatingPage(
            title: 'Nearby Mechanics',
            page: NearbyMechanicPage(),
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
    return Center(
      child: SpinKitFadingFour(
        color: tappedButtonColor,
      ),
    );
  }
}
