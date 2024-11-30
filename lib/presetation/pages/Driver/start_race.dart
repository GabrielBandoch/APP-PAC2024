import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/navigationBarComplete.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';

class StartRace extends StatefulWidget {
  const StartRace({super.key});

  @override
  _StartRace createState() => _StartRace();
}

class _StartRace extends State<StartRace> {
  int _selectedIndex = 2;
  bool isSideMenuOpen = false;
  String? _selectedClass = 'Turma A'; 

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
            children: [
              const SizedBox(height: 16),
              UserHeader(
                userName: 'Francisco Costa',
                avatarUrl: 'https://example.com/avatar.jpg',
                onAvatarTap: toggleSideMenu,
              ),
              const SizedBox(height: 50),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue), 
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedClass,
                        hint: const Text("Selecionar a turma"),
                        items: <String>['Turma A', 'Turma B', 'Turma C']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold, 
                                color: Colors.blue,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedClass = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
                    child: Center(
                      child: Text(
                        _selectedClass ?? 'Turma A',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Deseja iniciar corrida com a ',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: _selectedClass ?? 'TURMA A?',
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
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
                        child: const Text(
                          'SIM',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
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
                        child: const Text(
                          'NÃO',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
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
            child: const SideMenu(
              userName: 'Francisco Costa',
              avatarUrl: 'https://example.com/avatar.jpg',
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
}
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
