import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyMechanicPage extends StatefulWidget {
  static const String id = 'NearbyMechanicPage';
  final double? lat;
  final double? long;
  final dynamic decodedJsonData;
  const NearbyMechanicPage(
      {Key? key, this.decodedJsonData, this.lat, this.long})
      : super(key: key);
  @override
  _NearbyMechanicPageState createState() => _NearbyMechanicPageState();
}

class _NearbyMechanicPageState extends State<NearbyMechanicPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.lat!, widget.long!),
        zoom: 15.0,
      ),
    );
  }
}
