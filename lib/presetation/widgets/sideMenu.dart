import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pac20242/Provider/userProvider.dart';

class SideMenu extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const SideMenu({super.key, required this.userName, required this.avatarUrl});

  Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();
  }

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
                  title: const Text('Início',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    String userType = userProvider.userRole ?? 'desconhecido';
                    if(userType == "aluno"){
                      Navigator.pushNamed(context, '/home_resp');
                    } else if(userType == "condutor"){
                      Navigator.pushNamed(context, '/home_driver');
                    } else {
                      print("Erro: Tipo Desconhecido");
                    }
                    
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.notifications, color: Color(0xFF0056B3)),
                  title: const Text('Notificações',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pushNamed(context, '/notification');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle,
                      color: Color(0xFF0056B3)),
                  title: const Text('Minha Conta',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.attach_money, color: Color(0xFF0056B3)),
                  title: const Text('Pagamentos',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                ),
                ListTile(
                    leading:
                        const Icon(Icons.exit_to_app, color: Color(0xFF0056B3)),
                    title: const Text('Sair',
                        style: TextStyle(color: Colors.black)),
                    onTap: () async {
                      await singOut();
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (Route<dynamic> route) => false);
                      } else {
                        print("Erro ao realizar logout");
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
