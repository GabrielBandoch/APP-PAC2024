import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    routes: {
      '/payment': (context) => const Text('Payment Page'), // substitua por sua página real
      '/home_driver': (context) => const Text('Home Driver Page'), // substitua por sua página real
      '/home': (context) => HomePage(),
      '/profile': (context) => const Text('Profile Page'), // substitua por sua página real
      '/settings': (context) => const Text('Settings Page'), // substitua por sua página real
      '/manage_classes': (context) => const Text('Manage Classes Page'), // substitua por sua página real
    },
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Componente de boas-vindas no topo da página
          UserHeader(
            userName: 'Francisco Costa',
            avatarUrl: 'https://example.com/avatar.jpg',
            onAvatarTap: () {
              print('Avatar clicado!'); // Ação ao clicar no avatar
            },
          ),
          const SizedBox(height: 50),
          // Dropdown para selecionar a turma
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Selecione a turma para iniciar corrida',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Selecionar a turma"),
                    items: <String>['Turma A', 'Turma B', 'Turma C'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Botão para a turma selecionada
          Column(
            children: [
              const Text(
                'Turma selecionada',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                width: 160,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Turma A',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Confirmação para iniciar a corrida
          Column(
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Deseja iniciar corrida com a ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'TURMA A?',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Ação para "Sim"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('SIM'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Ação para "Não"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('NÃO'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pagamento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Turmas',
          ),
        ],
      ),
    );
  }
}

// Componente UserHeader
class UserHeader extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final VoidCallback onAvatarTap;

  const UserHeader({
    Key? key,
    required this.userName,
    required this.avatarUrl,
    required this.onAvatarTap,
  }) : super(key: key);

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
              onTap: onAvatarTap,
              child: CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 24,
              ),
            ),
          ),
          Text(
            'Olá, $userName',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}