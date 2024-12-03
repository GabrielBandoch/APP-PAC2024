import 'package:flutter/material.dart';

class UserGreeting extends StatefulWidget {
  final String userName;
  final String avatarUrl;
  final VoidCallback onAvatarTap;

  const UserGreeting({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.onAvatarTap,
  });

  @override
  _UserGreetingState createState() => _UserGreetingState();
}

class _UserGreetingState extends State<UserGreeting> {
  bool _hasNewNotifications = false; // Estado para indicar novas notificações

  // Função para simular a atualização de notificações
  void _toggleNotifications() {
    setState(() {
      _hasNewNotifications = !_hasNewNotifications; // Alterna o estado das notificações
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1577EA),
          width: 2,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: widget.onAvatarTap, // Usa o método onAvatarTap do widget pai
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.avatarUrl),
                radius: 24,
              ),
            ),
          ),
          Text(
            'Olá, ${widget.userName}', // Acessa as propriedades do widget
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Atualiza o estado das notificações quando o ícone for tocado
                _toggleNotifications();
                Navigator.pushNamed(context, '/notification');
              },
              child: Icon(
                _hasNewNotifications
                    ? Icons.notifications_active // Ícone de notificação ativa
                    : Icons.notifications, // Ícone de notificação normal
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
