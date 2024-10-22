import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              Positioned(
                top: screenHeight * -0.3,
                left: screenWidth * -0.2,
                child: Image.asset(
                  'assets/images/Decoration2.png',
                  width: screenWidth * 1.5,
                  height: screenHeight * 0.95,
                ),
              ),

              Positioned(
                bottom: -50,
                left: -50,
                child: Container(
                  width: screenWidth * 0.58,
                  height: screenWidth * 0.58,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1577EA),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                right: -screenWidth * 0.1,
                child: Container(
                  width: screenWidth * 0.42,
                  height: screenWidth * 0.42,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1577EA),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.08),
                      Image.asset(
                        '../../../assets/images/bibi.png',
                        height: screenHeight * 0.25,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          hintText: 'email@email.com',
                          hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: Color(0xFF1577EA),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: Color(0xFF1577EA),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Senha',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          hintText: 'Senha',
                          hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                          suffixIcon: const Icon(Icons.visibility),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: Color(0xFF1577EA),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              color: Color(0xFF1577EA),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      SizedBox(
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/complete_profile');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1577EA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Registrar',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: const Color(0xFF1577EA),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
