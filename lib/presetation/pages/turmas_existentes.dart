import 'package:flutter/material.dart';
import '../widgets/class_card.dart';
import '../widgets/create_class_button.dart';

class TurmasExistentesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Turmas Existentes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Turmas Existentes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return ClassCard(
                    className: 'Turma ${(index % 3) + 65}',
                    studentsAvatars: [
                      'assets/avatar1.png',
                      'assets/avatar2.png',
                      'assets/avatar3.png'
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            CreateClassButton(),
          ],
        ),
      ),
    );
  }
}
