import 'package:flutter/material.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({Key? key}) : super(key: key);

  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
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

  void _showAddStudentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Center(
            child: Text(
              "Deseja adicionar o aluno",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://example.com/student-avatar.jpg'),
                      radius: 25,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Gabriel Bandoch',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSuccessDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Center(
            child: Text(
              "Aluno adicionado com sucesso!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://example.com/student-avatar.jpg'),
                      radius: 25,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Gabriel Bandoch',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Criando uma Turma",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nome",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Digite o nome',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: 7,
              itemBuilder: (context, index) {
                if (index == 6) {
                  return Column(
                    children: [
                      const Text(
                        "Adicionar Aluno",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: _showAddStudentDialog,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Text(
                      "Aluno ${index + 1}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        print("Remover aluno ${index + 1}");
                      },
                      child: const Text(
                        "Remover",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
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
      ),
    );
  }
}
