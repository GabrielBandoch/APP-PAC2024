import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // script para adicioanr aluno
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(20),
        shape: CircleBorder(),
      ),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
