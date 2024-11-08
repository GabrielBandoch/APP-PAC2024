import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Criar Turma',
      debugShowCheckedModeBanner: false,
      home: CreateClassScreen(),
    );
  }
}

class CreateClassScreen extends StatefulWidget {
  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  int _selectedIndex = 2; // Define o índice inicial da BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Turmas Existentes',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 1 / 1.5,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, size: 40, color: Colors.blueAccent),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Turma ${String.fromCharCode(65 + index)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit_class');
                          },
                          child: Text(
                            'Editar',
                            style: TextStyle(color: Colors.blue),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Lógica de criar nova turma;
                // Caminho para a próxima página;
              },
              child: Text(
                'Criar Turma',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarComplete(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Lógica para navegar para diferentes páginas com base no índice selecionado
        },
      ),
    );
  }
}

class NavigationBarComplete extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const NavigationBarComplete({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        onTap(index);
        // Aqui você pode colocar a lógica de navegação, se necessário
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.attach_money, 0),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.directions_car, 1),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.home, 2),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.person, 3),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.settings, 4),
          label: '',
        ),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xFF515759),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    bool isSelected = selectedIndex == index;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1577EA) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : const Color(0xFF515759),
      ),
    );
  }
}
