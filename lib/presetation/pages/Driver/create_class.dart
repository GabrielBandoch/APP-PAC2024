import 'package:flutter/material.dart';
import 'package:pac20242/Provider/userProvider.dart';
import 'package:pac20242/presetation/pages/Driver/locationStudent.dart';
import 'package:provider/provider.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/utils/firebase_services.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  int _selectedIndex = 2;
  bool isSideMenuOpen = false;
  final String userName = "Gabriel";
  final String avatarUrl = "";
  final FireStoreServices firestoreServices = FireStoreServices();

  // Função que busca as turmas usando o FirestoreService
  Future<List<String>> _fetchClasses() async {
    try {
      // Obtendo o motoristaId do motorista usando o provider
      final motoristaId = Provider.of<UserProvider>(context, listen: false).uid;

      if (motoristaId == null) {
        // Caso o motoristaId seja null, retorne uma lista vazia ou mostre um erro
        print('Erro: motoristaId não encontrado');
        return [];
      }

      // Chama o método para buscar as turmas
      return await firestoreServices.fetchClasses(motoristaId);
    } catch (e) {
      print('Erro ao carregar as turmas: $e');
      return [];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/payment');
        break;
      case 1:
        Navigator.pushNamed(context, '/race');
        break;
      case 2:
        Navigator.pushNamed(context, '/home_driver');
        break;
      case 3:
        Navigator.pushNamed(context, '/createClass');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 55),
              UserGreeting(
                userName: userName,
                avatarUrl: 'https://via.placeholder.com/150',
                onAvatarTap: toggleSideMenu,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FutureBuilder<List<String>>(
                    future:
                        _fetchClasses(), // Chama a função que busca as turmas
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Erro ao carregar as turmas: ${snapshot.error}'));
                      }

                      final classes = snapshot.data ?? [];

                      if (classes.isEmpty) {
                        return const Center(
                            child: Text('Nenhuma turma encontrada.'));
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 1 / 1.5,
                        ),
                        itemCount: classes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                            ),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person,
                                        size: 40, color: Colors.blueAccent),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  classes[index], // Nome da turma
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    // Passando o id da turma como argumento
                                    Navigator.pushNamed(
                                      context,
                                      '/editClass',
                                      arguments: classes[
                                          index], // Aqui você passa o ID ou nome da turma
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side:
                                          const BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  child: Text(
                                    'Editar',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Espera até a turma ser criada e então atualiza a tela
                    await Navigator.pushNamed(context, '/locationClass');
                    setState(() {}); // Força a atualização da tela
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 48.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Criar Turma',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
}
