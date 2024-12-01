// lib/edit_class_page.dart
import 'package:flutter/material.dart';
import 'package:pac20242/utils/firebase_services.dart';

class EditClassPage extends StatefulWidget {
  final String classId; // Identificador da turma

  const EditClassPage({super.key, required this.classId});

  @override
  _EditClassPageState createState() => _EditClassPageState();
}

class _EditClassPageState extends State<EditClassPage> {
  List<Map<String, dynamic>> students = [];
  bool isLoading = true;
  final FireStoreServices firestoreServices = FireStoreServices();

  @override
  void initState() {
    super.initState();
    fetchStudents(
        widget.classId); // Carrega os alunos quando a página é inicializada
  }

  Future<void> fetchStudents(String classId) async {
    print("classId: $classId");
    if (classId.isEmpty) {
      print("ID da turma não pode ser vazio.");
      return;
    }

    try {
      // Busca o documento da turma
      final classDoc = await firestoreServices.instance
          .collection('turmas')
          .doc(classId)
          .get();

      if (!classDoc.exists) {
        throw Exception("Turma não encontrada");
      }

      final classData = classDoc.data();
      final List<String> studentIds = List<String>.from(
          classData!['alunos'] ?? []); // IDs dos alunos na turma

      List<Map<String, dynamic>> studentsList = [];

      // Para cada aluno, buscar os dados e adicionar à lista
      for (String alunoId in studentIds) {
        final alunoDoc = await firestoreServices.instance
            .collection('aluno')
            .doc(alunoId)
            .get();

        if (alunoDoc.exists) {
          final alunoData = alunoDoc.data();
          studentsList.add({
            "uid": alunoId,
            "nome": alunoData!['nome'],
          });
        }
      }

      // Atualiza o estado com a lista de alunos e remove o loading
      setState(() {
        students = studentsList;
        isLoading = false;
      });
    } catch (e) {
      print("Erro ao buscar alunos: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Editando TURMA',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: students.length + 1,
                      itemBuilder: (context, index) {
                        if (index == students.length) {
                          return const AddStudentButton();
                        } else {
                          final student = students[index];
                          return StudentTile(
                            studentName: student['nome'],
                            onRemove: () {
                              setState(() {
                                students.removeAt(index);
                              });
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/createClass');
                        },
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class StudentTile extends StatelessWidget {
  final String studentName;
  final VoidCallback onRemove;

  const StudentTile({
    super.key,
    required this.studentName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          studentName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: onRemove,
          child: const Text(
            'Remover',
            style: TextStyle(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class AddStudentButton extends StatelessWidget {
  const AddStudentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Função para adicionar um novo aluno
      },
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            'Adicionar Aluno',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
