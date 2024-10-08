import 'package:flutter/material.dart';
import 'statusCard_component.dart';

class StatusList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StatusCard(
            statusColor: Colors.green,
            nome: 'Felipe Chawiscki',
            data: '01/09/24'),
        StatusCard(
            statusColor: const Color.fromARGB(255, 214, 198, 49), nome: 'Gabriel Bandoch', data: '02/09/24'),
        StatusCard(
            statusColor: const Color.fromARGB(255, 189, 52, 42), nome: 'Gabriel Bandoch', data: '03/09/24'),
      ],
    );
  }
}
