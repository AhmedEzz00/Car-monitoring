import 'dart:async';

import 'package:car_conitoring/providers/update_database.dart';
import 'package:car_conitoring/services/location_services.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
//////////////////////
  final Position initialPosition;
//////////////////////
  static const String routeName = '/map_screen';

  final latitude;
  final longitude;
  final bool isSelecting;

  MapScreen(
      {this.initialPosition,
      this.latitude,
      this.longitude,
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
//////////////
  final LocationServices geoservice = LocationServices();
  Completer<GoogleMapController> _controller = Completer();
/////////////

  @override
  void initState() {
    // TODO: implement initState
    geoservice.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var location = Provider.of<UpdateDataBase>(context, listen: false);
    List<Marker> markers = [
      Marker(
        icon: BitmapDescriptor.defaultMarker,
        visible: true,
        markerId: MarkerId('Your location'),
        position: LatLng(
          location.latitude,
          location.longitude,
        ),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[600],
          title: Text("Location"),
        ),
        body:
            /*StreamBuilder(
          stream: null,
          builder: (context, carLocation) {
            return*/
            GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialPosition.latitude,
              widget.initialPosition.longitude,
            ),
            zoom: 16,
          ),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers.toSet(),
        ) //;
        //})  ,

        );
  }

  Future<void> centerScreen(Position position) async {
    var location = Provider.of<UpdateDataBase>(context, listen: false);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude), zoom: 16)));
  }
}
