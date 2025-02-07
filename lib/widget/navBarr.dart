// // import 'package:flutter/material.dart';
// // import 'package:flutter_clip_shadow/flutter_clip_shadow.dart';
// // import 'package:v1/generated/l10n.dart';
// // import 'package:v1/helper/Constanat.dart';
// // import 'package:v1/helper/helper.dart';
// // import 'package:v1/screens/HomeScreen.dart';
// // import 'package:v1/screens/driver.dart';
// // import 'package:v1/screens/map.dart';
// // import 'package:v1/screens/order.dart';
// // import 'package:v1/screens/orderDetls.dart';
// // import 'package:v1/screens/settings.dart';

// // class CustomNavBar extends StatelessWidget {
// //   final bool home;
// //   final bool details;
// //   final bool order;
// //   final bool profile;
// //   final bool more;

// //   const CustomNavBar(
// //       {this.home = false,
// //       this.details = false,
// //       this.order = false,
// //       this.profile = false,
// //       this.more = false});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 120,
// //       width: Helper.getScreenWidth(context),
// //       child: Stack(
// //         children: [
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: ClipShadow(
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: const Color.fromARGB(255, 209, 199, 199),
// //                   offset: Offset(
// //                     0,
// //                     0,
// //                   ),
// //                   blurRadius: 10,
// //                 ),
// //               ],
// //               clipper: CustomNavBarClipper(),
// //               child: Container(
// //                 height: 80,
// //                 width: Helper.getScreenWidth(context),
// //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// //                 color: primary,
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     GestureDetector(
// //                       onTap: () {
// //                         if (!more) {
// //                           Scaffold.of(context).openDrawer();
// //                         }
// //                       },
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           more
// //                               ? Icon(Icons.menu, size: 30)
// //                               : Icon(Icons.menu_open_sharp, size: 30),
// //                           more
// //                               ? Text(S.of(context).more,
// //                                   style: TextStyle(color: Colors.orange))
// //                               : Text(S.of(context).more),
// //                         ],
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         if (!details) {
// //                           Navigator.of(context)
// //                               .push(MaterialPageRoute(builder: (context) {
// //                             return Map_page();
// //                           }));
// //                         }
// //                       },
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           details
// //                               ? Icon(
// //                                   Icons.map_outlined,
// //                                   size: 30,
// //                                 )
// //                               : Icon(
// //                                   Icons.map,
// //                                   size: 30,
// //                                 ),
// //                           details
// //                               ? Text(S.of(context).map,
// //                                   style: TextStyle(color: Colors.orange))
// //                               : Text(S.of(context).map),
// //                         ],
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       width: 20,
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         if (!profile) {
// //                           Navigator.of(context)
// //                               .push(MaterialPageRoute(builder: (context) {
// //                             return Driver();
// //                           }));
// //                         }
// //                       },
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           profile
// //                               ? Icon(
// //                                   Icons.person_pin_rounded,
// //                                   size: 30,
// //                                 )
// //                               : Icon(
// //                                   Icons.person_pin_outlined,
// //                                   size: 30,
// //                                 ),
// //                           profile
// //                               ? Text(S.of(context).profile_nav,
// //                                   style: TextStyle(color: Colors.orange))
// //                               : Text(S.of(context).profile_nav),
// //                         ],
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         if (!order) {
// //                           Navigator.of(context)
// //                               .push(MaterialPageRoute(builder: (context) {
// //                             return order_page();
// //                           }));
// //                         }
// //                       },
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           order
// //                               ? Icon(
// //                                   Icons.manage_history_sharp,
// //                                   size: 30,
// //                                 )
// //                               : Icon(
// //                                   Icons.history_rounded,
// //                                   size: 30,
// //                                 ),
// //                           order
// //                               ? Text(S.of(context).orders,
// //                                   style: TextStyle(color: Colors.orange))
// //                               : Text(S.of(context).orders),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.topCenter,
// //             child: SizedBox(
// //               height: 70,
// //               width: 70,
// //               child: FloatingActionButton(
// //                 elevation: 0,
// //                 backgroundColor: home ? Colors.purple[700] : Colors.black,
// //                 onPressed: () {
// //                   if (!home) {
// //                     Navigator.of(context)
// //                         .push(MaterialPageRoute(builder: (context) {
// //                       return HomeScreen();
// //                     }));
// //                   }
// //                 },
// //                 child: Image.asset(
// //                     Helper.getAssetName("home_white.png", "virtual")),
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class CustomNavBarClipper extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     Path path = Path();
// //     path.moveTo(0, 0);
// //     path.lineTo(size.width * 0.3, 0);
// //     path.quadraticBezierTo(
// //       size.width * 0.375,
// //       0,
// //       size.width * 0.375,
// //       size.height * 0.1,
// //     );
// //     path.cubicTo(
// //       size.width * 0.4,
// //       size.height * 0.9,
// //       size.width * 0.6,
// //       size.height * 0.9,
// //       size.width * 0.625,
// //       size.height * 0.1,
// //     );
// //     path.quadraticBezierTo(
// //       size.width * 0.625,
// //       0,
// //       size.width * 0.7,
// //       0.1,
// //     );
// //     path.lineTo(size.width, 0);
// //     path.lineTo(size.width, size.height);
// //     path.lineTo(0, size.height);
// //     path.lineTo(0, 0);
// //     path.close();
// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
// //     return true;
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_clip_shadow/flutter_clip_shadow.dart';
// import 'package:v1/generated/l10n.dart';
// import 'package:v1/helper/Constanat.dart';
// import 'package:v1/helper/helper.dart';
// import 'package:v1/screens/HomeScreen.dart';
// import 'package:v1/screens/driver.dart';
// import 'package:v1/screens/map.dart';
// import 'package:v1/screens/order.dart';

// class CustomNavBar extends StatelessWidget {
//   final bool home;
//   final bool details;
//   final bool order;
//   final bool profile;
//   final bool more;

//   const CustomNavBar({
//     this.home = false,
//     this.details = false,
//     this.order = false,
//     this.profile = false,
//     this.more = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 120,
//       width: Helper.getScreenWidth(context),
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: ClipShadow(
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color.fromARGB(255, 209, 199, 199),
//                   offset: Offset(0, 0),
//                   blurRadius: 10,
//                 ),
//               ],
//               clipper: CustomNavBarClipper(),
//               child: Container(
//                 height: 80,
//                 width: Helper.getScreenWidth(context),
//                 color: primary,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     _buildNavItem(
//                       context,
//                       isActive: more,
//                       icon: more ? Icons.menu_open_sharp : Icons.menu,
//                       label: S.of(context).more,
//                       onTap: () {
//                         if (!more) Scaffold.of(context).openDrawer();
//                       },
//                     ),
//                     _buildNavItem(
//                       context,
//                       isActive: details,
//                       icon: details ? Icons.map_outlined : Icons.map,
//                       label: S.of(context).map,
//                       onTap: () {
//                         if (!details) {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(builder: (_) => Map_page()),
//                           );
//                         }
//                       },
//                     ),
//                     Spacer(), // مسافة لتوسيط الزر الرئيسي
//                     _buildNavItem(
//                       context,
//                       isActive: profile,
//                       icon: profile
//                           ? Icons.person_pin_rounded
//                           : Icons.person_pin_outlined,
//                       label: S.of(context).profile_nav,
//                       onTap: () {
//                         if (!profile) {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(builder: (_) => Driver()),
//                           );
//                         }
//                       },
//                     ),
//                     _buildNavItem(
//                       context,
//                       isActive: order,
//                       icon: order
//                           ? Icons.manage_history_sharp
//                           : Icons.history_rounded,
//                       label: S.of(context).orders,

//                       onTap: () {
//                         if (!order) {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(builder: (_) => order_page()),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: SizedBox(
//               height: 70,
//               width: 70,
//               child: FloatingActionButton(
//                 elevation: 0,
//                 backgroundColor: home ? Colors.purple[700] : Colors.black,
//                 onPressed: () {
//                   if (!home) {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(builder: (_) => HomeScreen()),
//                     );
//                   }
//                 },
//                 child: Image.asset(
//                   Helper.getAssetName("home_white.png", "virtual"),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(
//     BuildContext context, {
//     required bool isActive,
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon,
//                 size: 30, color: isActive ? Colors.orange : Colors.black),
//             Text(
//               label,
//               style: TextStyle(color: isActive ? Colors.orange : Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomNavBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width * 0.3, 0);
//     path.quadraticBezierTo(
//       size.width * 0.375,
//       0,
//       size.width * 0.375,
//       size.height * 0.1,
//     );
//     path.cubicTo(
//       size.width * 0.4,
//       size.height * 0.9,
//       size.width * 0.6,
//       size.height * 0.9,
//       size.width * 0.625,
//       size.height * 0.1,
//     );
//     path.quadraticBezierTo(
//       size.width * 0.625,
//       0,
//       size.width * 0.7,
//       0.1,
//     );
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(0, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_clip_shadow/flutter_clip_shadow.dart';
import 'package:v1/generated/l10n.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/helper/helper.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/driver.dart';
import 'package:v1/screens/map.dart';
import 'package:v1/screens/order.dart';

class CustomNavBar extends StatelessWidget {
  final bool home;
  final bool details;
  final bool order;
  final bool profile;
  final bool more;

  const CustomNavBar({
    super.key,
    this.home = false,
    this.details = false,
    this.order = false,
    this.profile = false,
    this.more = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: Helper.getScreenWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipShadow(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 209, 199, 199),
                  offset: Offset(0, 0),
                  blurRadius: 10,
                ),
              ],
              clipper: CustomNavBarClipper(),
              child: Container(
                height: 80,
                width: Helper.getScreenWidth(context),
                color: primary,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildNavItem(
                      context,
                      isActive: more,
                      icon: Icons.menu, // الأيقونة ثابتة
                      label: S.of(context).more,
                      onTap: () {
                        if (!more) Scaffold.of(context).openDrawer();
                      },
                    ),
                    _buildNavItem(
                      context,
                      isActive: details,
                      icon: Icons.map, // الأيقونة ثابتة
                      label: S.of(context).map,
                      onTap: () {
                        if (!details) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const MapPage()),
                          );
                        }
                      },
                    ),
                    const Spacer(), // مسافة لتوسيط الزر الرئيسي
                    _buildNavItem(
                      context,
                      isActive: profile,
                      icon: Icons.person_pin_outlined, // الأيقونة ثابتة
                      label: S.of(context).profile_nav,
                      onTap: () {
                        if (!profile) {
                          Navigator.of(context).pop();

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const Driver()),
                          );
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      isActive: order,
                      icon: Icons.history_rounded, // الأيقونة ثابتة
                      label: S.of(context).orders,
                      onTap: () {
                        if (!order) {
                          Navigator.of(context).pop();

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => order_page()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: home ? Colors.purple[700] : Colors.black,
                onPressed: () {
                  if (!home) {
                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  }
                },
                child: Image.asset(
                  Helper.getAssetName("home_white.png", "virtual"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required bool isActive,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black), // اللون الأسود ثابت
            Text(
              label,
              style: const TextStyle(color: Colors.black), // اللون الأسود ثابت
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(
      size.width * 0.375,
      0,
      size.width * 0.375,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.4,
      size.height * 0.9,
      size.width * 0.6,
      size.height * 0.9,
      size.width * 0.625,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      0,
      size.width * 0.7,
      0.1,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
