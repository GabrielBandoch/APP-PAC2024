import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/navigationBarComplete.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/utils/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenDriver extends StatefulWidget {
  const HomeScreenDriver({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenDriver> {
  int _selectedIndex = 2;
  bool isSideMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

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


  Future<void> _getUserData() async {
  final String? userId = await AuthService.getCurrentUserId();  // Pegando o ID do usuário logado
  if (userId != null) {
    try {
      // Buscando dados do usuário no Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('condutor')  // Coleção de usuários no Firestore
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 55), 
              UserGreeting(
                userName: userName,
                avatarUrl: avatarUrl,
                onAvatarTap: toggleSideMenu,
              ),
              const SizedBox(height: 30), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildIconButton('Cadastro', Icons.person_add_alt, '/createClass'),
                  buildIconButton('Pagamentos', Icons.attach_money, '/payment'),
                  buildIconButton('Recibos', Icons.receipt_long, '/recibos'),
                  buildIconButton('Corrida', Icons.location_on, '/race'),
                ],
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 35),
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/race');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1577EA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Iniciar Corrida',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
      bottomNavigationBar: NavigationBarComplete(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildIconButton(String label, IconData icon, String route) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1577EA), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route);
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
