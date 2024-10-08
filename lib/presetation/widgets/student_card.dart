import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;

  StudentCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/avatar.png'),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Ação ao remover aluno
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            'Remover',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
