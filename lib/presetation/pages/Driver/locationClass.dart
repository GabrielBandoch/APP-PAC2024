import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({Key? key}) : super(key: key);

  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredStudents = [];
  List<String> allStudents = [];
  List<String> classList = [];
  int _selectedIndex =
      -1; // Variável para controlar o índice do ícone selecionado

  Future<void> searchAlunos(String searchTerm) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('aluno').get();

      List<String> alunos =
          snapshot.docs.map((doc) => doc['nome'] as String).toList();

      setState(() {
        allStudents = alunos;
      });

      List<String> filtered = alunos
          .where(
              (aluno) => aluno.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      setState(() {
        filteredStudents = filtered;
      });
    } catch (e) {
      print('Erro ao buscar alunos: $e');
    }
  }

  void addStudentToClass(String student) {
    setState(() {
      classList.add(student);
    });
  }

  void removeStudentFromClass(String student) {
    setState(() {
      classList.remove(student);
    });
  }

  Widget _buildIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = isSelected ? -1 : index; // Alterna a seleção
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1577EA) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : const Color(0xFF515759),
        ),
      ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Barra de Busca",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _searchController,
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      searchAlunos(query);
                    } else {
                      setState(() {
                        filteredStudents = [];
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Pesquise os alunos',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (filteredStudents.isNotEmpty)
                  ...filteredStudents.map((student) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(student),
                        onTap: () {
                          addStudentToClass(student);
                        },
                      ),
                    );
                  }).toList()
                else
                  const Center(
                    child: Text('Nenhum aluno encontrado'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Alunos na Turma",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                ...classList.map((student) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.blue, width: 2),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(student),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          removeStudentFromClass(student);
                        },
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
