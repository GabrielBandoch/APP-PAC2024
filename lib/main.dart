import 'package:flutter/material.dart';
import 'package:pac20242/presetation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAC 2024',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(userName: 'Nome do Usuário'),
    );
  }
}
