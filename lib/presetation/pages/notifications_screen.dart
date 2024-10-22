import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/navigationBarReduced.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreen createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {
  int _selectedIndex = 2;
  bool isSideMenuOpen = false;
  final String userName = "Gabriel";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: UserGreeting(
                  userName: userName,
                  avatarUrl: avatarUrl,
                  onAvatarTap: toggleSideMenu,
                ),
              ),
              const SizedBox(height: 30),
              const Center(  // Centraliza o texto de "Notificações"
                child: Text(
                  'Notificações',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 100,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nenhuma notificação',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
      bottomNavigationBar: NavigationBarReduced(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
