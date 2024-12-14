// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:v1/generated/l10n.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/widget/custom_password.dart';
import 'package:v1/widget/custom_username.dart';
import 'package:v1/widget/cusyombuttom.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:v1/widget/splash.dart';

class LOGIN extends StatefulWidget {
  const LOGIN({super.key});

  @override
  State<LOGIN> createState() => _LOGINState();
}

class _LOGINState extends State<LOGIN> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    bool isloaded = false;
    GlobalKey<FormState> keyy = GlobalKey();
    return Form(
      key: keyy,
      child: ModalProgressHUD(
        inAsyncCall: isloaded,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary, // اللون الأول
                  secondary, // اللون الثاني
                ],
                begin: Alignment.topLeft, // بداية التدرج
                end: Alignment.bottomRight, // نهاية التدرج
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 100,
                    child: Image.asset("assets/images/00-removebg-preview.png"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      S.of(context).app_name,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).login,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 45,
                          fontFamily: 'Pacifico-Regular',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Emailtextfield(
                    hint: S.of(context).email,
                    onEmail: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  passwordtextfield(
                    hint: S.of(context).pass,
                    onpassword: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Custombutton(
                      button: S.of(context).login,
                      click: () {
                        if (password == "123123123" &&
                            email == "mhmed@gmail.com") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SplashScreen()));
                        } else {
                          printMassageTouser(
                              context, "user name& password wrong ");
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void printMassageTouser(BuildContext context, String massge) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(massge),
      ),
    );
  }
}
