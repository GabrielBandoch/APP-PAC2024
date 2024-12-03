import 'package:flutter/material.dart';

class location_s extends StatefulWidget {
  @override
  _Location_s createState() => _Location_s();
}

class _Location_s extends State<location_s> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          UserHeader(
            userName: 'Francisco Costa',
            avatarUrl: 'https://example.com/avatar.jpg',
            onAvatarTap: () {
              print('Avatar clicado!');
            },
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/bibi.png',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                StatusCard(
                  userName: 'Francisco Costa',
                  avatarUrl: 'https://example.com/avatar.jpg',
                ),
                StatusCard(
                  userName: 'Lucas',
                  avatarUrl: 'https://example.com/avatar2.jpg',
                ),
                StatusCard(
                  userName: 'Gabriel',
                  avatarUrl: 'https://example.com/avatar3.jpg',
                ),
              ],
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
                            const SizedBox(height: 32),
                  SizedBox(
                    width: 287,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        //_login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1577EA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          Text(
            'Olá, Condutor',
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

class StatusCard extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const StatusCard({
    Key? key,
    required this.userName,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationBarComplete extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const NavigationBarComplete(
      {super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
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
