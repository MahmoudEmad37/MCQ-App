import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mcq/utils/languages/translation.dart';
import 'package:mcq/screens/signup_screen.dart';
import 'package:mcq/services/theme_services.dart';
import 'package:mcq/theme.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        translations: Translation(),
        locale: const Locale('en'),
        fallbackLocale: const Locale('en'),
        title: 'MCQ App',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          backgroundColor: black,
          centered: true,
          splashIconSize: 800,
          splash: Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
          ),
          nextScreen: SignUpScreen(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
        )
      //NotificationScreen(payload: 'title|description|3/12/2022 3:36',),
    );
  }
}

