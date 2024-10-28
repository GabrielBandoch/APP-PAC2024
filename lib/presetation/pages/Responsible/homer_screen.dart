import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/navigationBarReduced.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/presetation/widgets/statusCard.dart';

class HomeScreenResponsavel extends StatefulWidget {
  const HomeScreenResponsavel({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenResponsavel> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 55),
              UserGreeting(
                userName: userName,
                avatarUrl: avatarUrl,
                onAvatarTap: toggleSideMenu,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildIconButton(
                    'Pagamentos',
                    Icons.attach_money,
                    () {
                      Navigator.pushNamed(context, '/payment');
                    },
                  ),
                  buildIconButton(
                    'Recibos',
                    Icons.receipt_long,
                    () {
                      Navigator.pushNamed(context, '/receipts');
                    },
                  ),
                  buildIconButton(
                    'Corrida',
                    Icons.location_on,
                    () {
                      Navigator.pushNamed(context, '/corrida');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      StatusCard(
                        userName: "Gabriel",
                        avatarUrl: "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
                        status: "Pago",
                        date: "01/01/2024",
                      ),
                      StatusCard(
                        userName: "Gabriel",
                        avatarUrl: "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
                        status: "Pendente",
                        date: "02/01/2024",
                      ),
                      StatusCard(
                        userName: "Gabriel",
                        avatarUrl: "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
                        status: "Atrasado",
                        date: "03/01/2024",
                      ),
                      const SizedBox(height: 20),
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

  Widget buildIconButton(String label, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1577EA), width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
