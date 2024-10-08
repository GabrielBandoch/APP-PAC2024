import 'package:flutter/material.dart';
import 'package:pac20242/presetation/pages/splash_screen.dart';
import 'package:pac20242/presetation/pages/login_page.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/login': (context) => LoginPage(), 
    },
  ));
}
