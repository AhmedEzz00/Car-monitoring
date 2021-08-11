import 'package:car_conitoring/services/location_services.dart';

import '../screens/google_map_screen.dart';
import 'package:flutter/material.dart';
//import 'package:location/location.dart';
import '../models/google_map_model.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';


class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Geolocator.getCurrentPosition();
    final staticMapImageUrl = locationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    print('${locData.latitude}');
    print('${locData.longitude}');
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

/////////////////////
  final geoService = LocationServices();
////////////////////

  /*Future<void> openMap() async {
    final locData = await Location().getLocation();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
            latitude: locData.latitude,
            longitude: locData.longitude,
            isSelecting: true),
      ),
    );
  }*/

  /* Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
              isSelecting: true,
            ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    // ...
  }*/

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return FutureProvider(
      create: (context) => geoService.getInitialPosition(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: deviceSize.height * 5 / 11,
            width: deviceSize.width-deviceSize.width/19,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _previewImageUrl == null
                ? Text(
                    'No Location Chosen',
                    textAlign: TextAlign.center,
                  )
                : Consumer<Position>(
                    builder: (context, position, widget) {
                      return position!=null?GestureDetector(
                        child: Image.network(
                          _previewImageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => MapScreen(
                                initialPosition: position,
                                  //latitude: locData.latitude,
                                  //longitude: locData.longitude,
                                  isSelecting: true),
                            ),
                          );
                        },
                      ):Center(child: CircularProgressIndicator(),);
                    },
                  ),
          ),
          FlatButton.icon(
            splashColor: Colors.black,
            icon: Icon(
              Icons.location_on,
            ),
            label: Text('Current Location'),
            textColor: Colors.black,
            onPressed: _getCurrentUserLocation,
          ),
        ],
      ),
    );
  }
}
