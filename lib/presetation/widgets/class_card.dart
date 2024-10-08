import 'package:flutter/material.dart';
import 'edit_button.dart';

class ClassCard extends StatelessWidget {
  final String className;
  final List<String> studentsAvatars;

  ClassCard({required this.className, required this.studentsAvatars});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blue, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              className,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: studentsAvatars.map((avatar) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(avatar), 
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            EditButton(), 
          ],
        ),
      ),
    );
  }
}
