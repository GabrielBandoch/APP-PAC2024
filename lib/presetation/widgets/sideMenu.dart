import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const SideMenu({super.key, required this.userName, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 150,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  radius: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  'Olá, $userName',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home, color: Color(0xFF0056B3)), 
                  title: const Text('Início', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications, color: Color(0xFF0056B3)), 
                  title: const Text('Notificações', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle, color: Color(0xFF0056B3)), 
                  title: const Text('Minha Conta', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.attach_money, color: Color(0xFF0056B3)),
                  title: const Text('Pagamentos', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Color(0xFF0056B3)),
                  title: const Text('Sair', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
