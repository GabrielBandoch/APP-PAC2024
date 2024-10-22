import 'package:flutter/material.dart';
import 'package:pac20242/presetation/pages/notifications_screen.dart';
import 'package:pac20242/presetation/pages/splash_screen.dart';
import 'package:pac20242/presetation/pages/login_screen.dart';
import 'package:pac20242/presetation/pages/register_screen.dart';
import 'package:pac20242/presetation/pages/completeProfile_screen.dart';
import 'package:pac20242/presetation/pages/selectRole_screen.dart';
import 'package:pac20242/presetation/pages/Driver/homed_screen.dart';
import 'package:pac20242/presetation/pages/Responsible/homer_screen.dart';
import 'package:pac20242/presetation/pages/payment_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/login': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/complete_profile': (context) => CompleteProfileScreen(),
      '/select_role': (context) => SelectRoleScreen(),
      '/home_driver': (context) => HomeScreenDriver(),
      '/home_resp': (context) => HomeScreenResponsavel(),
      '/payment': (context) => PaymentScreen(),
      '/notification': (context) => NotificationsScreen(),
    },
  ));
}
