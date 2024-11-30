import 'package:flutter/material.dart';

class SchedulePaymentPage extends StatefulWidget {
  @override
  _SchedulePaymentPageState createState() => _SchedulePaymentPageState();
}

class UserGreeting extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final VoidCallback onAvatarTap;

  const UserGreeting({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.onAvatarTap,
  });

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/notification');
              },
              child: const Icon(
                Icons.notifications,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SchedulePaymentPageState extends State<SchedulePaymentPage> {
    DateTime? selectedDate;
    int _selectedIndex = 2;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserGreeting(
                userName: 'Francisco',
                avatarUrl: 'https://via.placeholder.com/150',
                onAvatarTap: () {
                  print('Avatar clicado!');
                },
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  "Pagamento pendente",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
              "Responsável", 
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "FRANCISCO MARCELO CAETANO COSTA",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Aluno",
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "ERIC GABRIEL CAETANO",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Data de vencimento",
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "01/09/2024",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
              SizedBox(height: 90),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Deseja mudar a data de pagamento?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    ),
                                  ),
                                ),
                              child: child!,
                              );
                            },
                          );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        "Abrir Calendário",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              if (selectedDate != null)
                Center(
                  child: Text(
                    "Data selecionada: ${selectedDate!.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para confirmar o pagamento
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
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