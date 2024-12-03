import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assinatura Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignatureScreen(),
    );
  }
}

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  
   @override
  void initState() {
    super.initState();
    // Força o modo paisagem  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  
  // Controlador para a assinatura
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: const Color.fromARGB(255, 35, 29, 85),
    exportBackgroundColor: const Color.fromARGB(0, 255, 255, 255),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assinatura Digital'),
      ),
      body: Column(
        children: [
          // Quadro de assinatura
          Expanded(
            child: Signature(
              controller: _controller,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          SizedBox(height: 10),
          // Botões em linha
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botão para salvar a assinatura
              ElevatedButton(
                onPressed: () async {
                  if (_controller.isNotEmpty) {
                    final signature = await _controller.toPngBytes();
                    
                    if (signature != null) {
                      // Faça o que desejar com a assinatura, como salvar ou inserir em um documento
                      Navigator.pushNamed(context, '/login');
                    }
                  }
                },
                child: Text('Salvar'),
              ),
              // Botão para limpar o quadro
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                },
                child: Text('Limpar'),
              ),
            ],
          ),
          SizedBox(height: 20), // Espaçamento inferior
        ],
      ),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  final Uint8List signature;

  DocumentScreen(this.signature);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documento'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Assinatura no documento'),
            SizedBox(height: 20),
            // Exibir a assinatura no documento
            Image.memory(signature),
          ],
        ),
      ),
    );
  }
}
