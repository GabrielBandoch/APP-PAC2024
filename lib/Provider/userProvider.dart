import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? _userRole;

  User? get user => _user;
  String? get userRole => _userRole;

  //get uid => null;
  String? get uid => _user?.uid;

  Future<void> initializeUser(User firebaseUser) async {
    _user = firebaseUser;
    bool userFound = false;

    try {
      // Tenta buscar o usuário na coleção "aluno"
      DocumentSnapshot alunoDoc = await FirebaseFirestore.instance
          .collection('aluno')
          .doc(firebaseUser.uid)
          .get();

      if (alunoDoc.exists) {
        _userRole = 'aluno';
        userFound = true;
      }

      // Se não encontrar em "aluno", tenta em "condutor"
      if (!userFound) {
        DocumentSnapshot condutorDoc = await FirebaseFirestore.instance
            .collection('condutor')
            .doc(firebaseUser.uid)
            .get();

        if (condutorDoc.exists) {
          _userRole = 'condutor';
          userFound = true;
        }
      }

      // Se o usuário não for encontrado em nenhuma coleção
      if (!userFound) {
        print('Documento do usuário não encontrado em nenhuma coleção.');
        _userRole = 'unknown'; // Define um valor padrão
      }
    } catch (e) {
      print('Erro ao buscar informações do Firestore: $e');
      _userRole = 'error'; // Define um valor padrão em caso de erro
    }

    if (_userRole == 'unknown') {
      print('Tipo de usuário não identificado.');
    }

    notifyListeners(); // Notifica os consumidores que o estado foi atualizado
  }

  void clearUser() {
    _user = null;
    _userRole = null;
    notifyListeners(); // Notifica os consumidores para redefinir o estado
  }
}
