import 'package:connectivity_plus/connectivity_plus.dart'; // أضف هذه الاستيرادات
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/api_model/profileData.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/models/profile_data.dart';
import 'package:v1/models/userModel.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/drawble.dart';
import 'package:v1/screens/loginPage.dart';
import 'package:v1/widget/navBarr.dart';
import 'package:v1/widget/profile_buttom.dart/number.dart';
import '../generated/l10n.dart';

class Driver extends StatefulWidget {
  const Driver({super.key, this.id});
  final int? id;

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  late Future<ProfileData> futureProfile;
  final ProfileService profileService = ProfileService();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProfileData(); // جلب البيانات المخزنة مؤقتًا فقط
  }

  Future<void> _fetchProfileData({bool forceRefresh = false}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final userModel = Provider.of<UserModel>(context, listen: false);
      futureProfile = profileService.fetchDriverProfile(userModel.iddd,
          forceRefresh: forceRefresh);
    } on SocketException catch (e) {
      setState(() {
        _errorMessage =
            'No internet connection. Please check your network settings.';
      });
    } on HandshakeException catch (e) {
      setState(() {
        _errorMessage = 'Please check your connection.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> refreshProfile() async {
    // التحقق من الاتصال بالإنترنت
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _errorMessage =
            'No internet connection. Please check your network settings.';
      });
      return; // لا يتم تنفيذ الـ Refresh إذا لم يكن هناك اتصال
    }

    // إذا كان هناك اتصال، يتم تنفيذ الـ Refresh
    await _fetchProfileData(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).profile_nav,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: primary,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          // التحقق من الاتصال بالإنترنت قبل تنفيذ الـ Refresh
          final connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            setState(() {
              _errorMessage =
                  'No internet connection. Please check your network settings.';
            });
            return; // لا يتم تنفيذ الـ Refresh إذا لم يكن هناك اتصال
          }

          // إذا كان هناك اتصال، يتم تنفيذ الـ Refresh
          await refreshProfile();
        },
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: refreshProfile,
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : FutureBuilder<ProfileData>(
                    future: futureProfile,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'No internet connection. Please check your network settings.'));
                      } else if (snapshot.hasData) {
                        ProfileData profile = snapshot.data!;
                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(60),
                                      bottomRight: Radius.circular(60),
                                    ),
                                  ),
                                  child: ClipPath(
                                    clipper: BottomWaveClipper(),
                                    child: Container(
                                      color: primary,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  right: 120,
                                  child: CircleAvatar(
                                    radius: 80,
                                    backgroundImage: profile.image_api != null
                                        ? NetworkImage(profile.image_api!)
                                        : const AssetImage(
                                                'assets/images/imge.jpeg')
                                            as ImageProvider,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 80),
                            buildName(profile),
                            const SizedBox(height: 16),
                            NumbersWidget(
                              order: profile.order_Number_api ?? 0,
                              rate: profile.rate_api ?? 0,
                              age: profile.age_api ?? 0,
                            ),
                            const SizedBox(height: 48),
                            buildAbout(profile),
                            const SizedBox(
                                height: 500), // مساحة إضافية لاختبار السحب
                          ],
                        );
                      } else {
                        return const Center(child: Text('No data found'));
                      }
                    },
                  ),
      ),
      bottomNavigationBar: const CustomNavBar(
        profile: true,
      ),
    );
  }

  Widget buildName(ProfileData profile) => Column(
        children: [
          Text(
            profile.name_api ?? 'no name',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            profile.email_api ?? 'user@gmail.com',
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      );

  Widget buildAbout(ProfileData profile) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).about,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              profile.about ?? "No about information available",
              style: const TextStyle(fontSize: 16, height: 1.4),
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
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height,
      size.width,
      size.height - 30,
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
