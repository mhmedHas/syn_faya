import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/helper/darkmode.dart';
import 'package:v1/helper/user_prefranses.dart';
import 'package:v1/models/userModel.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/map.dart';
import 'package:v1/screens/order.dart';
import 'package:v1/screens/privacy_page.dart';
import 'package:v1/screens/settings.dart';

import 'package:v1/widget/navBarr.dart';
import 'package:v1/widget/profile_buttom.dart/profileWidget.dart';
import 'package:v1/widget/profile_buttom.dart/number.dart';
import 'package:v1/widget/cusyombuttom.dart';
import 'package:v1/widget/splash.dart';

import '../generated/l10n.dart';

class Driver extends StatefulWidget {
  const Driver({super.key});

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).profile_nav,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: primary, // Color of the appBar
        automaticallyImplyLeading:
            false, // This hides the default hamburger icon
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    HomeScreen())); // This will take the user back to the previous screen
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            clipBehavior: Clip
                .none, // Allows positioning the profile image outside the container
            children: [
              // Container with yellow color, rounded corners, and wave at the bottom
              Container(
                height: 120, // Increased height for better visual spacing
                decoration: BoxDecoration(
                  color: primary, // Set the container color to yellow
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: ClipPath(
                  clipper:
                      BottomWaveClipper(), // Apply wavy effect at the bottom
                  child: Container(
                    color: primary, // Ensure the background is yellow
                  ),
                ),
              ),
              // Profile image positioned above the container
              Positioned(
                top: 30,
                right: 120,
                // Adjust top to position the profile image above the container
                child: CircleAvatar(
                  radius: 80, // Profile image size
                  backgroundImage: AssetImage('assets/images/44.jpg'),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 80), // Space between profile and name
          buildName(user),
          const SizedBox(height: 16), // Smaller space between name and numbers
          NumbersWidget(),
          const SizedBox(height: 48), // Space before "About"
          buildAbout(user),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        profile: true, // Pass the required parameters
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            S.of(context).Billgets,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            S.of(context).BIllgetsemailcom,
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).about,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

// CustomClipper for the wavy shape at the bottom
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 30); // Adjust the height of the wave
    path.quadraticBezierTo(
      size.width * 0.5, size.height, // Create the wave shape
      size.width, size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
