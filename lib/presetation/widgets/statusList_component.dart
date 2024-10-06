import 'package:flutter/material.dart';
import 'statusCard_component.dart';

class StatusList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StatusCard(statusColor: Colors.green, nome: 'Felipe Chawiscki', data: '01/09/24'),
        StatusCard(statusColor: Colors.yellow, nome: 'Carlos Silva', data: '02/09/24'),
        StatusCard(statusColor: Colors.red, nome: 'Ana Souza', data: '03/09/24'),
      ],
    );
  }
}
