import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:v1/firebase_options.dart';
import 'package:v1/helper/darkmode.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/loginPage.dart';
import 'package:v1/widget/splash.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), // أبعاد التصميم الأصلية (عرض x ارتفاع)
      minTextAdapt: true, // تمكين تكيف النص
      splitScreenMode: true, // تمكين وضع الشاشة المقسمة
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => ThemeProvider()), // ThemeProvider
            ChangeNotifierProvider(
                create: (_) => SwitchProvider()), // SwitchProvider
            ChangeNotifierProvider(create: (_) => UserModel()), // UserModel
          ],
          child: const MyApp(), // تشغيل التطبيق
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(
                    1.0), // استبدال textScaleFactor بـ textScaler
              ),
              child: child!,
            );
          },
          locale: themeProvider.locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins-Regular'),
          home: const LOGIN(),
        );
      },
    );
  }
}
