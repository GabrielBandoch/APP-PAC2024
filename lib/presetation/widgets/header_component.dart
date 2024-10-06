import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String userName;
  final String profileImageUrl;

  Header({required this.userName, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(profileImageUrl),
        ),
        SizedBox(width: 10),
        Text('Olá, $userName'),
        Spacer(),
        IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
      ],
    );
  }
}
