import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pac20242/Provider/userProvider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registrar usuário
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

// Fazer login
  Future<User?> loginInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Inicializa o estado do usuário no Provider
        await Provider.of<UserProvider>(context, listen: false)
            .initializeUser(user);

        // Redireciona para a tela correta com base no tipo de usuário
        String? userRole =
            Provider.of<UserProvider>(context, listen: false).userRole;

        if (userRole == 'aluno') {
          Navigator.pushReplacementNamed(context, '/home_resp');
        } else if (userRole == 'condutor') {
          Navigator.pushReplacementNamed(context, '/home_driver');
        } else {
          print(
              "Tipo de usuário não identificado ou documento não encontrado.");
        }

        return user;
      } else {
        print("Erro: usuário não encontrado.");
        return null;
      }
    } catch (e) {
      print("Erro no login: $e");
      return null;
    }
  }

  // Fazer logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Verificar estado do usuário
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // Reset de senha, olhar mais tarde
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Email de reset enviado.");
    } catch (e) {
      print("Erro ao enviar email de reset: $e");
    }
  }
}
