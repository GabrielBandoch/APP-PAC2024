import 'package:flutter/material.dart';
import 'package:pac20242/Provider/userProvider.dart';
import 'package:provider/provider.dart';
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

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FireStoreServices bd = FireStoreServices();
  // bd.addPayment();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/complete': (context) => const CompleteProfileScreen(),
        '/select_role': (context) => const SelectRoleScreen(),
        '/home_driver': (context) => const HomeScreenDriver(),
        '/home_resp': (context) => const HomeScreenResponsavel(),
        '/payment': (context) => const PaymentScreen(),
        '/notification': (context) => const NotificationsScreen(),
        '/recibos': (context) => const ReceiptsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/esenha': (context) => ForgotPasswordScreen(),
        '/reset': (context) => const ResetPasswordScreen(),
        '/redirect': (context) => const RedirectScreen(),
        '/gerarRecibo': (context) => const ReceiptPreviewScreen(),
        '/turmas': (context) => TurmasPage(),
        '/race': (context) => StartRace(),
        '/editClass': (context) => EditClassPage(),
        '/createClass': (context) => CreateClassScreen(),
      },
    );
  }
}
