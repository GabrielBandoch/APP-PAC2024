import 'package:flutter/material.dart';
import 'package:pac20242/Provider/userProvider.dart';
import 'package:pac20242/presetation/pages/Driver/locationStudent.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/utils/firebase_services.dart';
import 'package:provider/provider.dart';

class StartRace extends StatefulWidget {
  const StartRace({super.key});

  @override
  _StartRace createState() => _StartRace();
}

class _StartRace extends State<StartRace> {
  int _selectedIndex = 2;
  bool isSideMenuOpen = false;
  String? _selectedClass;
  List<String> _classes = [];
  final FireStoreServices firestoreServices = FireStoreServices();

  // Função para buscar turmas do Firebase
  Future<void> _fetchClasses() async {
    try {
      final motoristaId = Provider.of<UserProvider>(context, listen: false).uid;

      if (motoristaId == null) {
        print('Erro: motoristaId não encontrado');
        return;
      }

      final fetchedClasses = await firestoreServices.fetchClasses(motoristaId);
      setState(() {
        _classes = fetchedClasses;
        _selectedClass = _classes.isNotEmpty
            ? _classes[0]
            : null; // Seleciona a primeira turma por padrão
      });
    } catch (e) {
      print('Erro ao carregar turmas: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClasses(); // Chama a função para buscar turmas ao iniciar o widget
  }

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
                        items: _classes.map((String value) {
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
                        _selectedClass ?? 'Nenhuma turma selecionada',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
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
                          text: _selectedClass ?? 'TURMA NÃO DEFINIDA?',
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
                          Navigator.pushNamed(context, '/locationStudent');
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
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                              color: Colors.white, fontWeight: FontWeight.bold),
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
