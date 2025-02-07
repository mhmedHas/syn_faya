import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:v1/generated/l10n.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/widget/custom_password.dart';
import 'package:v1/widget/custom_username.dart';
import 'package:v1/widget/cusyombuttom.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:v1/widget/splash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // أضف هذه الحزمة

class UserModel with ChangeNotifier {
  int? _iddd;

  int? get iddd => _iddd;

  Future<void> setUserId(int id) async {
    _iddd = id;
    notifyListeners(); // إشعار الكلاسات المشتركة بالتغيير

    // حفظ المتغير في SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('iddd', id);
  }

  Future<void> loadUserId() async {
    // تحميل المتغير من SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _iddd = prefs.getInt('iddd');
    notifyListeners();
  }
}

class LOGIN extends StatefulWidget {
  const LOGIN({super.key});

  @override
  State<LOGIN> createState() => _LOGINState();
}

class _LOGINState extends State<LOGIN> {
  String? email;
  String? password;
  bool isloaded = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn(); // تحقق من وجود بيانات مستخدم محفوظة
  }

  // دالة للتحقق من وجود بيانات مستخدم محفوظة
  Future<void> _checkIfLoggedIn() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    await userModel.loadUserId(); // تحميل المتغير المحفوظ

    if (userModel.iddd != null) {
      // إذا كان هناك بيانات محفوظة، انتقل مباشرة إلى الشاشة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
    }
  }

  // دالة لتسجيل الدخول
  Future<void> _login() async {
    if (email == null || password == null) {
      printMassageTouser(
          context, "الرجاء إدخال البريد الإلكتروني وكلمة المرور");
      return;
    }

    setState(() {
      isloaded = true; // عرض مؤشر التحميل
    });

    try {
      final response = await http.post(
        Uri.parse('http://alwarsh.net/api/login.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print(email);
      print(password);
      print(response.statusCode);

      print(json.decode(response.body));

      final Map<String, dynamic> data = json.decode(response.body);

      print(data);

      final int iddd = data['data']['id'];

      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(iddd);

      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

      if (data['status'] == true) {
        // تسجيل الدخول ناجح
        printMassageTouser(context, "تم تسجيل الدخول بنجاح");

        // تحديث المتغير iddd في UserModel
        final userModel = Provider.of<UserModel>(context, listen: false);
        await userModel.setUserId(iddd);

        // الانتقال إلى الشاشة الرئيسية
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
        );
      } else if (data['status'] == false) {
        // تسجيل الدخول فشل
        printMassageTouser(context, "فشل تسجيل الدخول");
      }
    } catch (e) {
      // خطأ في الشبكة أو الخادم
      printMassageTouser(context, "  خطا ف الشبكه :");
    } finally {
      setState(() {
        isloaded = false; // إخفاء مؤشر التحميل
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    height: 100,
                    child: Image.asset("assets/images/00-removebg-preview.png"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      S.of(context).app_name,
                      style: const TextStyle(
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
                        style: const TextStyle(
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
                    click: _login, // استدعاء دالة تسجيل الدخول
                  ),
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
