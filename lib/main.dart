import './providers/authentication.dart';
import './providers/update_database.dart';
import './screens/control_screen.dart';
import './screens/google_map_screen.dart';
import './screens/login_screen.dart';
import './services/location_services.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './providers/authentication.dart';

import './screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Authentication()),
        ChangeNotifierProvider(create: (ctx) => LocationServices()),
        ChangeNotifierProxyProvider<Authentication, UpdateDataBase>(
          create: null,
          update: (ctx, auth, _) =>
              UpdateDataBase(token: auth.token, userId: auth.userId),
        ),
        
      ],
      child: Consumer<Authentication>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyCar',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ControlScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : LoginScreen(),
                ),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            ControlScreen.routeName: (ctx) => ControlScreen(),
            //MapScreen.routeName: (ctx) => MapScreen()
          },
        ),
      ),
    );
  }
}
