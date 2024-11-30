import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';

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
                avatarUrl: avatarUrl,
                onAvatarTap: toggleSideMenu,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          side: const BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person, size: 40, color: Colors.blueAccent),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Turma ${String.fromCharCode(65 + index)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/editClass');
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(color: Colors.blue),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/locationClass');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Criar Turma',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
