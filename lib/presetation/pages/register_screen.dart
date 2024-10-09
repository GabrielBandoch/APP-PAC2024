import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: Color(0xFF1577EA),
            ),
          ),
          Positioned(
            top: -50,
            right: -80,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: Color(0xFF1577EA),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -100,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: Color(0xFF1577EA),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      '../../../assets/images/bibi.png', 
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Campo de Email
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'email@email.com',
                      hintStyle: TextStyle(color: Color(0xFFBCBCBC)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFF1577EA),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFF1577EA),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Campo de Senha
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'Senha',
                      hintStyle: TextStyle(color: Color(0xFFBCBCBC)),
                      suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFF1577EA),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFF1577EA),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  // Botão de Registro
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação de registrar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1577EA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w800, // Extra Bold
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
