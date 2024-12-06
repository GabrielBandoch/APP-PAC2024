import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({Key? key}) : super(key: key);

  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredStudents = [];
  List<String> allStudents = [];
  List<String> classList = [];

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

  Future<void> createClass() async {
    String className = _nameController.text.trim();
    if (className.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, insira um nome para a turma.")),
      );
      return;
    }

    if (classList.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("A turma precisa de pelo menos 3 alunos.")),
      );
      return;
    }

    try {
      // Obtendo o UID do motorista (usuário logado)
      User? motorista = FirebaseAuth.instance.currentUser;
      if (motorista == null) {
        throw Exception('Motorista não autenticado.');
      }

      // Criando o UID da turma
      final turmaDoc = FirebaseFirestore.instance.collection('turmas').doc();
      String turmaUid = turmaDoc.id;

      // Adicionando o UID do motorista e o UID da turma ao documento da turma
      await turmaDoc.set({
        'nome': className,
        'alunos': classList,
        'motoristaId': motorista.uid, // UID do motorista
        'uid': turmaUid, // UID da turma
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Turma criada com sucesso!")),
      );

      // Limpa os campos após criar a turma
      setState(() {
        _nameController.clear();
        classList.clear();
        filteredStudents.clear();
      });
    } catch (e) {
      print("Erro ao criar turma: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao criar turma.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Turma'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Conteúdo da tela
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Digite o nome da turma',
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            suffixIcon: const Icon(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              side: const BorderSide(color: Colors.blue, width: 2),
                            ),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(student),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle),
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
            ),
          ),
          // Botão fixo na parte inferior
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: createClass,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                ),
                child: const Text(
                  'Criar Turma',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
