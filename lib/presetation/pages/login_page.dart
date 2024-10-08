import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/custom_input.dart';
import 'package:pac20242/presetation/widgets/rounded_button.dart';
import 'package:pac20242/presetation/widgets/outlined_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),
            CustomInput(
              label: 'Usuário',
              hintText: 'Digite seu usuário',
            ),
            SizedBox(height: 20),
            CustomInput(
              label: 'Senha',
              hintText: 'Digite sua senha',
              obscureText: true,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Ação esqueceu senha
                },
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundedButton(
              text: 'Login',
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                // Ação login
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.blue,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "ou",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.blue,
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Não tem uma conta?',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 10),
            OutlinedButtonCustom(
              text: 'Crie sua conta',
              onPressed: () {
                // Ação criar conta
              },
            ),
          ],
        ),
      ),
    );
  }
}
