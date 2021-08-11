import 'package:car_conitoring/widgets/location_input.dart';
import '../providers/update_database.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  static const String routeName = '/control_screen';

  @override
  _ControlScreenState createState() => _ControlScreenState();
  
}

class _ControlScreenState extends State<ControlScreen> {
  String caractive;

  bool trusted = false;
  String trustedUser = '0';

  bool trustedToggle() {
    if (trustedUser == '0') {
      trustedUser = '1';
    } else {
      trustedUser = '0';
    }
    return !trusted;
  }

  Future<void> currentStatus(BuildContext context) async {
    var carActive = await Provider.of<UpdateDataBase>(context);
    carActive.listenCarStatus();
    caractive = carActive.carState;
  }

  @override
  Widget build(BuildContext context) {
    currentStatus(context);

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text('CONTROL'),
        ),
        drawer: AppDrawer(),
        body: Container(
          color: Colors.grey[400],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                  ),
                  width: deviceSize.width * 0.80,
                  height: deviceSize.height*0.2,
                  padding: EdgeInsets.all(15.0),
                  child: trusted
                      ? Center(
                        child: Text(
                            'TRUSTED',
                            style: TextStyle(color: Colors.green,fontSize: 30),
                          ),
                      )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlatButton(
                              height: deviceSize.height / 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.red,
                              onPressed: () {
                                print('object');
                                // Provider.of<UpdateDataBase>(context,listen: false).listenCarStatus();
                                Provider.of<UpdateDataBase>(context,
                                        listen: false)
                                    .stopCar('0');
                              },
                              child: Text(
                                'Stop the car',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  trusted ? '' : 'Car Status: ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  trusted
                                      ? ''
                                      : (caractive == '0'
                                          ? 'Inactive'
                                          : 'Active'),
                                  style: TextStyle(
                                      color: (caractive == '0'
                                          ? Colors.red[900]
                                          : Colors.green[900]),
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 3,
                ),
                LocationInput(),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        width: deviceSize.width * 0.50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mobile_friendly_outlined,
                                color: trusted ? Colors.green : Colors.red,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('TRUSTED'),
                              SizedBox(
                                width: 30,
                              ),
                              Switch(
                                onChanged: (value) {
                                  setState(() {
                                    Provider.of<UpdateDataBase>(context,
                                            listen: false)
                                        .trustedUser(trustedUser);
                                    trusted = trustedToggle();
                                  });
                                },
                                value: trusted,
                                activeColor: Colors.green,
                                autofocus: true,
                              ),
                              //SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
