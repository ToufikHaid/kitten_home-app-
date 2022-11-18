import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cat_adoption/Authentifinication/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Helpers/Transition.dart';
import 'curved_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cat Adoption',
        debugShowCheckedModeBanner: false,
        //theme: ThemeData(fontFamily: "Montserrat"),
        home: AnimatedSplashScreen(
          splash: 'Assets/Images/catlogo.png',
          splashIconSize: 200,
          nextScreen: Transition(),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: Colors.orangeAccent,
          pageTransitionType: PageTransitionType.bottomToTop,
        ));
  }
}
