import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String _userType; // 'aluno' ou 'condutor'
  String _userName;

  // Construtor
  UserModel({required String userType, required String userName})
      : _userType = userType,
        _userName = userName;

  // Getters
  String get userType => _userType;
  String get userName => _userName;

  // Setters com notificação
  void setUserType(String type) {
    _userType = type;
    notifyListeners(); // Notifica os listeners da mudança
  }

  void setUserName(String name) {
    _userName = name;
    notifyListeners(); // Notifica os listeners da mudança
  }
}
