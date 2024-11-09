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
import 'package:pac20242/presetation/pages/receipts_screen.dart';
import 'package:pac20242/presetation/pages/myAccount_screen.dart';
import 'package:pac20242/presetation/pages/forgotPass_screen.dart';
import 'package:pac20242/presetation/pages/forgotPassL_screen.dart';
import 'package:pac20242/presetation/pages/gov.dart';
import 'package:pac20242/presetation/pages/Driver/receiptsG.dart';
import 'package:pac20242/presetation/pages/Driver/turma.dart';
import 'package:pac20242/presetation/pages/Driver/start_race.dart';
import 'package:pac20242/presetation/pages/Driver/edit_class.dart';
import 'package:pac20242/presetation/pages/Driver/create_class.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/login': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/complete': (context) => CompleteProfileScreen(),
      '/select_role': (context) => SelectRoleScreen(),
      '/home_driver': (context) => HomeScreenDriver(),
      '/home_resp': (context) => HomeScreenResponsavel(),
      '/payment': (context) => PaymentScreen(),
      '/notification': (context) => NotificationsScreen(),
      '/recibos': (context) => ReceiptsScreen(),
      '/profile': (context) => ProfileScreen(),
      '/esenha': (context) => ForgotPasswordScreen(),
      '/reset': (context) => ResetPasswordScreen(userName: 'Gabriel'),
      '/redirect': (context) => RedirectScreen(),
      '/gerarRecibo': (context) => ReceiptPreviewScreen(),
      '/turmas': (context) => TurmasPage(),
      '/race': (context) => StartRace(),
      '/editClass': (context) => EditClassPage(),
      '/createClass': (context) => CreateClassScreen(),
    },
  ));
}
