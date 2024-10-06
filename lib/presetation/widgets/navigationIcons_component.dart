import 'package:flutter/material.dart';

class NavigationIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIcon(Icons.attach_money, 'Pagamentos'),
        _buildIcon(Icons.receipt, 'Recibos'),
        _buildIcon(Icons.location_on, 'Corrida'),
      ],
    );
  }

  Column _buildIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 40),
        Text(label),
      ],
    );
  }
}
