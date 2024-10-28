import 'package:flutter/material.dart';

class NavigationBarComplete extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const NavigationBarComplete({super.key, required this.selectedIndex, required this.onTap});

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
            Navigator.pushNamed(context, '/home_driver');
            break;
          case 2:
            Navigator.pushNamed(context, '/home_driver');
            break;
          case 3:
            Navigator.pushNamed(context, '/home_driver');
            break;
          case 4:
            Navigator.pushNamed(context, '/home_driver');
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
