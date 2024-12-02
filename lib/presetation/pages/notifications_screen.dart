import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/navigationBarReduced.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pac20242/utils/firebase_auth.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreen createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {

    @override
  void initState() {
    super.initState();
    _getUserData();
  }

  int _selectedIndex = 2;
  bool isSideMenuOpen = false;
  String userName = "Carregando...";
  final String avatarUrl = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleSideMenu() {
    setState(() {
      isSideMenuOpen = !isSideMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: UserGreeting(
                  userName: userName,
                  avatarUrl: avatarUrl,
                  onAvatarTap: toggleSideMenu,
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Notificações',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 100,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nenhuma notificação',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isSideMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: toggleSideMenu,
                child: Container(
                  color: Colors.black54,
                ),
              ),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: isSideMenuOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: SideMenu(
              userName: userName,
              avatarUrl: avatarUrl,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarReduced(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }


  Future<void> _getUserData() async {
  final String? userId = await AuthService.getCurrentUserId();  // Pegando o ID do usuário logado
  if (userId != null) {
    try {
      // Buscando dados do usuário no Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('aluno')  // Coleção de usuários no Firestore
          .doc(userId)  // Usando o ID do usuário como documento
          .get();

      // Verifica se o widget ainda está montado antes de chamar setState
      if (mounted) {
        if (userDoc.exists) {
          String fullName = userDoc['nome'] ?? "Nome não encontrado";  // Pega o nome completo
          userName = fullName.split(' ').first;  // Pega o primeiro nome
        } else {
          userName = "Usuário não encontrado";
        }
        setState(() {});  // Atualiza o estado
      }
    } catch (e) {
      print('Erro ao buscar usuário: $e');
      if (mounted) {
        userName = "Erro ao carregar dados";
        setState(() {});  // Atualiza o estado com o erro
      }
    }
  } else {
    if (mounted) {
      userName = "Não logado";  // Caso o usuário não esteja logado
      setState(() {});  // Atualiza o estado
    }
  }
}

}

