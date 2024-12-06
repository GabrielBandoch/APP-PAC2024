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

  Future<void> resetPassword(BuildContext context, String email) async {
    if (email.isEmpty ||
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
            .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Por favor, insira um e-mail válido.")));
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("E-Mail de redefinição enviado com sucesso.")));
    } catch (e) {
      Navigator.of(context).pop();
      String errorMessage = "Erro desconhecido, tenta novamente mais tarde.";

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = "O e-mail fornecido não é válido.";
            break;
          case 'user-not-found':
            errorMessage = "Nenhum usuário encontrado com esse e-mail.";
            break;
          default:
            errorMessage = "Erro ao enviar o e-mail de redefinição de senha.";
            break;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
