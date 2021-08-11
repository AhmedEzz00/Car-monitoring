import '../screens/google_map_screen.dart';

import '../providers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.black,
            title: Text('SERVICES'),
            automaticallyImplyLeading: false,
          ),
          /*ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Find My Car'),
            onTap:(){Navigator.of(context).pushNamed(MapScreen.routeName);},
          ),
          Divider(
            color: Colors.black,
          ),*/
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Authentication>(context,listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
