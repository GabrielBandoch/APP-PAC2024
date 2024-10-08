import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final Color statusColor;
  final String nome;
  final String data;

  StatusCard(
      {required this.statusColor, required this.nome, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: statusColor,
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
        title: Text(nome, style: TextStyle(color: Colors.white)),
        subtitle: Text('Data: $data', style: TextStyle(color: Colors.white)),
        trailing: Text('Atrasado', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
