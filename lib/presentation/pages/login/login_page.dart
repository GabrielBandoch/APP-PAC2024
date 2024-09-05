import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 50,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuário',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Esqueceu sua senha?',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue, // Corrigido aqui
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('OU'),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text('Crie sua conta'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Corrigido aqui
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
