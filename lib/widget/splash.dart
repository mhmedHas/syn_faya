import 'package:flutter/material.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/loginPage.dart';

import '../generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a splash screen
    Future.delayed(const Duration(seconds: 1), () {
      // Navigate to the main page after the delay
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 200),
            const Spacer(flex: 4),
            Center(
              child: Text(
                S.of(context).app_name,
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Spacer(flex: 1),
            Center(
              child: SizedBox(
                  height: 200,
                  width: 300,
                  child: Image.asset("assets/images/00-removebg-preview.png")),
            ),
            const Spacer(flex: 2),

            // Text(
            //   ' Eng.Mohamed Ibrahim ',
            //   style: TextStyle(
            //     fontSize: 22,
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const Spacer(flex: 1),

            // Add the footer content here
            const Spacer(flex: 2),
            // This will add "CodeCrafter" in the center
            const Text(
              'CodeCrafters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(
              flex: 1,
            )
            // This will add the phone numbers at the bottom left and right
          ],
        ),
      ),
    );
  }
}
