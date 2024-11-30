import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlunoSearchWidget extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onSelectedAlunos;

  const AlunoSearchWidget({Key? key, required this.onSelectedAlunos})
      : super(key: key);

  @override
  _AlunoSearchWidgetState createState() => _AlunoSearchWidgetState();
}

class _AlunoSearchWidgetState extends State<AlunoSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<Map<String, dynamic>> _selectedAlunos = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchAlunos(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('aluno')
        .where('nome', isGreaterThanOrEqualTo: query)
        .where('nome', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    setState(() {
      _searchResults = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'uid': doc.id,
          'nome': data['nome'],
          // Adicione outros campos se necessário
        };
      }).toList();
    });
  }

  void _addAluno(Map<String, dynamic> aluno) {
    if (!_selectedAlunos.any((selected) => selected['uid'] == aluno['uid'])) {
      setState(() {
        _selectedAlunos.add(aluno);
        _searchResults.clear();
        _searchController.clear();
      });
      widget.onSelectedAlunos(_selectedAlunos);
    }
  }

  void _removeAluno(String uid) {
    setState(() {
      _selectedAlunos.removeWhere((aluno) => aluno['uid'] == uid);
    });
    widget.onSelectedAlunos(_selectedAlunos);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          onChanged: _searchAlunos,
          decoration: InputDecoration(
            labelText: 'Buscar Aluno',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        if (_searchResults.isNotEmpty)
          ..._searchResults.map((aluno) => ListTile(
                title: Text(aluno['nome']),
                onTap: () => _addAluno(aluno),
              )),
        SizedBox(height: 10),
        if (_selectedAlunos.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alunos Selecionados:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ..._selectedAlunos.map((aluno) => Chip(
                    label: Text(aluno['nome']),
                    onDeleted: () => _removeAluno(aluno['uid']),
                  )),
            ],
          ),
      ],
    );
  }
}
