import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/api_model/profileData.dart';
import 'package:v1/helper/darkmode.dart';
import 'package:v1/models/profile_data.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/driver.dart';
import 'package:v1/screens/loginPage.dart';
import 'package:v1/screens/map.dart';
import 'package:v1/screens/order.dart';
import 'package:v1/screens/privacy_page.dart';
import 'package:v1/screens/settings.dart';
import 'package:v1/widget/splash.dart';
import '../generated/l10n.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late Future<ProfileData> _profileDataFuture;

  @override
  void initState() {
    super.initState();
    // جلب بيانات السائق عند بدء تشغيل الـ Drawer
    final userModel = Provider.of<UserModel>(context, listen: false);

    _profileDataFuture = ProfileService().fetchDriverProfile(userModel.iddd);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber[700]!, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<ProfileData>(
          future: _profileDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // عرض مؤشر تحميل أثناء جلب البيانات
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // عرض رسالة خطأ في حالة فشل جلب البيانات
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              // عرض رسالة إذا لم تكن هناك بيانات
              return Center(child: Text('No data available'));
            } else {
              // عرض البيانات بعد جلبها بنجاح
              final profileData = snapshot.data!;
              return ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      profileData.name_api ?? 'No Name', // اسم السائق
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    accountEmail: Text(
                      profileData.email_api ?? 'user@gmail.com', // بريد السائق
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundImage: profileData.image_api != null
                            ? NetworkImage(profileData.image_api!)
                            : const AssetImage('assets/images/44.jpg')
                                as ImageProvider,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Driver()),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber[700],
                    ),
                  ),
                  ListTile(
                    title: Text(S.of(context).orders,
                        style: const TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.menu, color: Colors.black),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => order_page(),
                      ));
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).map,
                        style: const TextStyle(fontSize: 16)),
                    trailing:
                        const Icon(Icons.map_outlined, color: Colors.black),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const MapPage(),
                      ));
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).privacy,
                        style: const TextStyle(fontSize: 16)),
                    trailing:
                        const Icon(Icons.privacy_tip, color: Colors.black),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const PrivacyPage(),
                      ));
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).change_language,
                        style: const TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.language, color: Colors.black),
                    onTap: () {
                      Navigator.of(context).pop();
                      final provider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      provider.toggleLocale();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SplashScreen()));
                    },
                  ),
                  const Divider(thickness: 1.0),
                  ListTile(
                    title: Text(S.of(context).close,
                        style: const TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.cancel, color: Colors.black),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
