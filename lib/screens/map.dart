import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/helper/darkmode.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/driver.dart';
import 'package:v1/screens/order.dart';
import 'package:v1/screens/privacy_page.dart';
import 'package:v1/screens/settings.dart';
import 'package:v1/widget/navBarr.dart';
import 'package:v1/widget/splash.dart';

import '../generated/l10n.dart';

class Map_page extends StatefulWidget {
  const Map_page({super.key});

  @override
  _Map_pageState createState() => _Map_pageState();
}

class _Map_pageState extends State<Map_page> {
  bool _mapFailedToLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).map,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        automaticallyImplyLeading:
            false, // Prevents the default drawer icon from showing
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.of(context).pop();

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber[700]!, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  S.of(context).Billgets,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                accountEmail: Text(
                  S.of(context).BIllgetsemailcom,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/44.jpg'),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Driver()),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                ),
              ),
              ListTile(
                title:
                    Text(S.of(context).orders, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.menu, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => order_page(),
                  ));
                },
              ),
              ListTile(
                title: Text(S.of(context).map, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.map_outlined, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Map_page(),
                  ));
                },
              ),
              ListTile(
                title: Text(S.of(context).api, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.settings, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Settings_page(),
                  ));
                },
              ),
              ListTile(
                title:
                    Text(S.of(context).privacy, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.privacy_tip, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PrivacyPage(),
                  ));
                },
              ),
              ListTile(
                title: Text(S.of(context).change_language,
                    style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.language, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleLocale();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                },
              ),
              Divider(thickness: 1.0),
              ListTile(
                title:
                    Text(S.of(context).close, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.cancel, color: Colors.black),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/map.png'),
            // image: NetworkImage(
            //     'https://www.lindsaysilberman.com/wp-content/uploads/2020/01/how-to-use-google-maps-trip-planner.png'),
            fit: BoxFit.cover,
          ),
        ),
      )
      // : GoogleMap(
      //     initialCameraPosition: CameraPosition(
      //       target: _initialPosition,
      //       zoom: 12.0,
      //     ),
      //     onMapCreated: (controller) {
      //       _mapController = controller;
      //     },
      //     onCameraMove: (position) {
      //       // Handle camera movement
      //     },
      //     myLocationEnabled: true,
      //     myLocationButtonEnabled: true,
      //     onMapLoadFailed: () {
      //       setState(() {
      //         _mapFailedToLoad = true;
      //       });
      //     },
      //   ),
      ,
      bottomNavigationBar: CustomNavBar(
        details: true,
      ),
    );
  }
}
