import 'package:flutter/material.dart';

class EditClassPage extends StatelessWidget {
  const EditClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Editando TURMA A',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65, 
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  if (index == 15) {
                    return AddStudentButton();
                  } else {
                    return StudentTile();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/createClass');
                  },
                  child: const Text(
                    'Confirmar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Botão de Cancelar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StudentTile extends StatelessWidget {
  const StudentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        const Text(
          'Gabriel Bandoch',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: () {
            // Função para remover o aluno
          },
          child: const Text(
            'Remover',
            style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class AddStudentButton extends StatelessWidget {
  const AddStudentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Função para adicionar um novo aluno
      },
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            'Adicionar Aluno',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
