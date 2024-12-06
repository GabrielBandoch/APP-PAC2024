import 'package:flutter/material.dart';
import 'package:pac20242/utils/firebase_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredStudents = []; // Lista de alunos filtrados
  final FireStoreServices _fireStoreServices = FireStoreServices();

  // Função para atualizar a busca
  void _searchAlunos() async {
    String searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      // Buscar alunos no Firestore
      List<Map<String, dynamic>> alunos =
          await _fireStoreServices.searchAlunos(searchTerm);
      setState(() {
        filteredStudents = alunos; // Atualiza a lista com os resultados
      });
    } else {
      setState(() {
        filteredStudents =
            []; // Limpa a lista se o campo de busca estiver vazio
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar Alunos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por nome',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchAlunos, // Chama a função de busca ao clicar
                ),
              ),
              onChanged: (value) =>
                  _searchAlunos(), // Chama a função ao digitar
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  var aluno = filteredStudents[index];
                  return ListTile(
                    title: Text(aluno['nome'] ?? 'Sem nome'),
                    subtitle: Text(aluno['cidade'] ?? 'Sem cidade'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
