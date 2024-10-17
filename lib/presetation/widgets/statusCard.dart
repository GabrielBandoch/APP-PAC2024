import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final String status;
  final String date;

  StatusCard({
    required this.userName,
    required this.avatarUrl,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'Pendente':
        color = Color(0xFFC1C329);
        break;
      case 'Pago':
        color = Color(0xFF0EB540);
        break;
      case 'Atrasado':
        color = Color(0xFFB91C0E);
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
