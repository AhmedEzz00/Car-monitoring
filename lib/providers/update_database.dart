import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UpdateDataBase with ChangeNotifier {
  final String token;
  final String userId;
  String carStatus = '';
  String carLatitude = '0.0';
  String carLongitude = '0.0';
  String trusted;
  String stop;
  double latitude = 0.0;
  double longitude = 0.0;

  UpdateDataBase({
    this.token,
    this.userId,
  });

  Future<void> stopCar(String sCommand) async {
    await listenCarStatus();
    final url =
        'https://api.thingspeak.com/update?api_key=X2GQMLNKR4UPDFXR&field1=$sCommand&field2=$trusted&field3=$carStatus&field4=$latitude&field5=$longitude';

    try {
      await http.post(
        url,
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> trustedUser(String trusteduser) async {
    await listenCarStatus();
    String url =
        'https://api.thingspeak.com/update?api_key=X2GQMLNKR4UPDFXR&field1=$stop&field2=$trusteduser&field3=$carStatus&field4=$latitude&field5=$longitude';
    try {
      await http.post(
        url,
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> listenCarStatus() async {
    String url =
        'https://api.thingspeak.com/channels/1348106/feeds.json?results=1';
    //'https://api.thingspeak.com/channels/1348106/fields/2.json';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      if (data['feeds'].last['field3'].toString() != null) {
        carStatus = data['feeds'].last['field3'].toString();
      }
      if (data['feeds'].last['field2'].toString() != null) {
        trusted = data['feeds'].last['field2'].toString();
      }
      if (data['feeds'].last['field1'].toString() != null) {
        stop = data['feeds'].last['field1'].toString();
      }
      if (data['feeds'].last['field4'].toString() != null&& data['feeds'].last['field4'].toString() != 'NULL'&& data['feeds'].last['field4'].toString() != 'No Fix'&& data['feeds'].last['field4'].toString() != 'null') {
        carLatitude = data['feeds'].last['field4'].toString();
        latitude = double.parse(carLatitude);
      }

      if (data['feeds'].last['field5'].toString() != null && data['feeds'].last['field5'].toString() != 'NULL'&& data['feeds'].last['field5'].toString() != 'No Fix'&& data['feeds'].last['field5'].toString() != 'null') {
        carLongitude = data['feeds'].last['field5'].toString();
        longitude = double.parse(carLongitude);
      }
      //print('${latitude * 2}');
      if (carStatus != null) {
        print('car status: $carStatus');
      }
      //print(carLatitude);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  String get carState {
    return carStatus;
  }
}
