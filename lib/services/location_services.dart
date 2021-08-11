import 'package:flutter/foundation.dart';
import '../models/user_location.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices with ChangeNotifier {
  // double _latitude;
//double _longitude;

/////////////////////////

  /* UserLocation _currentLocation;


  get latitude{
    getLMyocation();
    return _currentLocation.latitude;
  }

  get longitude{
    getLMyocation();
    return _currentLocation.longitude;
  }

  

  
Future<UserLocation> getLMyocation() async{
  var location= Location();
    try{
      var userLocation= await location.getLocation();
      _currentLocation= UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    }catch(error){
      throw error;
    }
    notifyListeners();
    return _currentLocation;
  }*/

  ///////////////////////////////////////////

  final Geolocator geo = Geolocator();
  Stream<Position> getCurrentLocation() {
    //var locationOptions= LocationOptions(accuracy:LocationAccuracy.high ,distanceFilter: 10);
    return Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.best, distanceFilter: 10);
  }

  Future<Position> getInitialPosition() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
