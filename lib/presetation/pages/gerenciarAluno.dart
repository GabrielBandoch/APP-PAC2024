import 'package:flutter/material.dart';
import '../widgets/confirmcancel_buttons.dart';
import '../widgets/add_button.dart';
import '../widgets/student_card.dart';

class GerenciarAlunoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciar Alunos")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return StudentCard(name: 'Gabriel Bandoch');
                },
              ),
            ),
            AddButton(),
            SizedBox(height: 20),
            ConfirmCancelButtons(),
          ],
        ),
      ),
    );
  }
}
