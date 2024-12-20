import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusCard extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final String status;
  final String date;
  final double value;

  const StatusCard({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.status,
    required this.date,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    Color color;

    DateTime paymentDate = DateFormat('dd/MM/yyyy').parse(date);
    DateTime currentDate = DateTime.now();

    if (paymentDate.isBefore(currentDate)) {
      color = const Color(0xFFB91C0E);
    } else {
      switch (status) {
        case 'Pendente':
          color = const Color(0xFFC1C329);
          break;
        case 'Pago':
          color = const Color(0xFF0EB540);
          break;
        default:
          color = Colors.grey;
      }
    }

    String formattedDate = DateFormat('dd/MM/yyyy').format(paymentDate);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                const SizedBox(width: 10),
                Text(
                  userName,
                  style: const TextStyle(
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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'R\$ ${value.toStringAsFixed(2)}',
                  style: const TextStyle(
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
