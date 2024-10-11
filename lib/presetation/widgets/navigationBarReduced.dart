import 'package:flutter/material.dart';
import 'package:pac20242/presetation/pages/teste.dart';

class NavigationBarReduced extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  NavigationBarReduced({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/teste');
            break;
          case 1:
            Navigator.pushNamed(context, '/teste');
            break;
          case 2:
            Navigator.pushNamed(context, '/teste');
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
          icon: _buildIcon(Icons.menu, 1),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.settings, 2),
          label: '',
        ),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFF515759),
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
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF1577EA) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Color(0xFF515759),
      ),
    );
  }
}
