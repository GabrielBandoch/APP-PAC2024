import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
  get instance => null;

  Future<Map<String, dynamic>> obterDocumento(String colecao, String documentId) async {
  try {
    DocumentSnapshot documento = await FirebaseFirestore.instance
        .collection(colecao)
        .doc(documentId)
        .get();

    if (documento.exists) {
      return documento.data() as Map<String, dynamic>? ?? {}; // Retorna o mapa ou um mapa vazio
    } else {
      print("Documento não encontrado!");
      return {};
    }
  } catch (e) {
    print('Erro ao obter documento: $e');
    return {};
  }
  }


  // Adicionar Aluno
  Future<void> addAluno(String nomeE, String telefoneE, String numeroCasa,
      String nomeRua, String cidade, String estado, String cep) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        CollectionReference aluno =
            FirebaseFirestore.instance.collection('aluno');

        await aluno.doc(user.uid).set({
          'nome': nomeE,
          'telefone': telefoneE,
          'numeroCasa': numeroCasa,
          'nomeRua': nomeRua,
          'cidade': cidade,
          'estado': estado,
          'cep': cep,
          'email': user.email,
          'uid': user.uid,
          'role': 'aluno',
        });

        print('Aluno adicionado com sucesso');
      } else {
        print('Usuário não autenticado');
      }
    } catch (e) {
      print('Erro ao adicionar aluno: $e');
    }
  }

  // Função para buscar os dados do aluno
  Future<Map<String, dynamic>?> getAlunoData(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('aluno')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Erro ao buscar dados do aluno: $e');
    }
    return null;
  }

  // Função para atualizar os dados do aluno
  Future<void> updateAluno(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection('aluno')
          .doc(userId)
          .update(updatedData);
      print('Dados do aluno atualizados com sucesso.');
    } catch (e) {
      print('Erro ao atualizar dados do aluno: $e');
    }
  }

  // Adicionar condutor
  Future<void> addCondutor(String nomeC, String telefoneC) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        CollectionReference condutor =
            FirebaseFirestore.instance.collection('condutor');

        await condutor.doc(user.uid).set({
          'nome': nomeC,
          'telefone': telefoneC,
          'email': user.email,
          'uid': user.uid,
          'role': 'condutor',
        });

        print('Condutor adicionado com sucesso');
      } else {
        print('Usuário não autenticado');
      }
    } catch (e) {
      print('Erro ao adicionar condutor: $e');
    }
  }

  // Função para buscar os dados do condutor
  Future<Map<String, dynamic>?> getCondutorData(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('condutor')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Erro ao buscar dados do condutor: $e');
    }
    return null;
  }

  // Função para atualizar os dados do condutor
  Future<void> updateCondutor(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection('condutor')
          .doc(userId)
          .update(updatedData);
      print('Dados do condutor atualizados com sucesso.');
    } catch (e) {
      print('Erro ao atualizar dados do condutor: $e');
    }
  }

  Future<void> deleteAluno(String userId) async {
    await FirebaseFirestore.instance.collection('aluno').doc(userId).delete();
  }

  Future<void> deleteCondutor(String userId) async {
    await FirebaseFirestore.instance
        .collection('condutor')
        .doc(userId)
        .delete();
  }

  Future<void> deleteAccount(String userId, String userRole) async {
    // Excluir os dados do Firestore dependendo do papel (aluno ou condutor)
    if (userRole == 'aluno') {
      await deleteAluno(userId);
    } else {
      await deleteCondutor(userId);
    }

    // Excluir a conta no Firebase Authentication
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      print('Erro ao excluir conta: $e');
      throw Exception('Erro ao excluir conta');
    }
  }

  // Turmas

  // // // Criar turma
  // Future<void> criarTurma(
  //     String nomeTurma, List<String> alunosSelecionados) async {
  //   try {
  //     // Obtém o motorista logado via UserProvider
  //     User? motorista = FirebaseAuth.instance.currentUser;
  //     if (motorista == null) {
  //       throw Exception('Motorista não autenticado.');
  //     }

  //     // Referência para o documento da turma
  //     final turmaDoc = FirebaseFirestore.instance.collection('turmas').doc();
  //     List<Map<String, dynamic>> alunosComEndereco = [];

  //     // Buscar informações dos alunos selecionados
  //     for (String alunoId in alunosSelecionados) {
  //       final alunoDoc = await FirebaseFirestore.instance
  //           .collection('aluno')
  //           .doc(alunoId)
  //           .get();

  //       if (alunoDoc.exists) {
  //         final alunoData = alunoDoc.data();
  //         alunosComEndereco.add({
  //           "uid": alunoId,
  //           "nome": alunoData!['nome'],
  //           "endereco": {
  //             "estado": alunoData['estado'],
  //             "cidade": alunoData['cidade'],
  //             "nomeRua": alunoData['nomeRua'],
  //             "numeroCasa": alunoData['numeroCasa'],
  //             "cep": alunoData['cep'],
  //           },
  //         });
  //       }
  //     }

  //     // Salvar a turma no Firestore, incluindo o UID da turma
  //     await turmaDoc.set({
  //       "id": turmaDoc.id, // ID gerado automaticamente pelo Firestore
  //       "uid": turmaDoc.id, // O UID da turma será o mesmo que o ID do documento
  //       "nome": nomeTurma,
  //       "motoristaId": motorista.uid,
  //       "alunos": alunosComEndereco,
  //     });

  //     print('Turma criada com sucesso com UID ${turmaDoc.id}.');
  //   } catch (e) {
  //     print('Erro ao criar turma: $e');
  //   }
  // }

  // Criar turma
  Future<void> criarTurma(
      String nomeTurma, List<String> alunosSelecionados) async {
    try {
      // Obtém o motorista logado via UserProvider
      User? motorista = FirebaseAuth.instance.currentUser;
      if (motorista == null) {
        throw Exception('Motorista não autenticado.');
      }

      // Referência para o documento da turma
      final turmaDoc = FirebaseFirestore.instance.collection('turmas').doc();
      List<Map<String, dynamic>> alunosComEndereco = [];

      // Buscar informações dos alunos selecionados
      for (String alunoId in alunosSelecionados) {
        final alunoDoc = await FirebaseFirestore.instance
            .collection('aluno')
            .doc(alunoId)
            .get();

        if (alunoDoc.exists) {
          final alunoData = alunoDoc.data();
          alunosComEndereco.add({
            "uid": alunoId,
            "nome": alunoData!['nome'],
            "endereco": {
              "estado": alunoData['estado'],
              "cidade": alunoData['cidade'],
              "nomeRua": alunoData['nomeRua'],
              "numeroCasa": alunoData['numeroCasa'],
              "cep": alunoData['cep'],
            },
          });
        }
      }

      // Salvar a turma no Firestore, incluindo o UID da turma
      await turmaDoc.set({
        "id": turmaDoc.id, // ID gerado automaticamente pelo Firestore
        "uid": turmaDoc.id, // O UID da turma será o mesmo que o ID do documento
        "nome": nomeTurma,
        "motoristaId": motorista.uid,
        "alunos": alunosComEndereco,
      });

      print('Turma criada com sucesso com UID ${turmaDoc.id}.');
    } catch (e) {
      print('Erro ao criar turma: $e');
    }
  }

  // Adicionar aluno na turma
  Future<void> adicionarAlunoNaTurma(String turmaId, String alunoId) async {
    try {
      User? motorista = FirebaseAuth.instance.currentUser;
      if (motorista == null) {
        throw Exception('Motorista não autenticado.');
      }

      final turmaDoc =
          FirebaseFirestore.instance.collection('turmas').doc(turmaId);
      final turmaData = await turmaDoc.get();

      if (!turmaData.exists) {
        throw Exception('Turma não encontrada.');
      }

      // Verificar se o motorista logado é o proprietário da turma
      if (turmaData.data()?['motoristaId'] != motorista.uid) {
        throw Exception('Você não tem permissão para modificar esta turma.');
      }

      final alunoDoc = await FirebaseFirestore.instance
          .collection('aluno')
          .doc(alunoId)
          .get();

      if (alunoDoc.exists) {
        final alunoData = alunoDoc.data();
        final alunoComEndereco = {
          "uid": alunoId,
          "nome": alunoData!['nome'],
          "endereco": {
            "estado": alunoData['estado'],
            "cidade": alunoData['cidade'],
            "nomeRua": alunoData['nomeRua'],
            "numeroCasa": alunoData['numeroCasa'],
            "cep": alunoData['cep'],
          },
        };

        // Atualiza a turma adicionando o aluno
        await turmaDoc.update({
          "alunos": FieldValue.arrayUnion([alunoComEndereco]),
        });

        print('Aluno adicionado à turma com sucesso.');
      } else {
        throw Exception('Aluno não encontrado.');
      }
    } catch (e) {
      print('Erro ao adicionar aluno à turma: $e');
    }
  }

  // Remover Aluno da turma
  Future<void> removerAlunoDaTurma(String turmaId, String alunoId) async {
    try {
      User? motorista = FirebaseAuth.instance.currentUser;

      if (motorista == null) {
        throw Exception('Motorista não autenticado.');
      }

      // Referência para o documento da turma
      final turmaDoc =
          FirebaseFirestore.instance.collection('turmas').doc(turmaId);

      // Buscar dados da turma
      final turmaData = await turmaDoc.get();

      if (!turmaData.exists) {
        throw Exception('Turma não encontrada.');
      }

      // Verificar se o motorista logado é o responsável pela turma
      if (turmaData.data()?['motoristaId'] != motorista.uid) {
        throw Exception('Você não tem permissão para modificar esta turma.');
      }

      // Recuperar alunos e filtrar o aluno a ser removido
      List<dynamic> alunos = turmaData.data()?['alunos'] ?? [];
      alunos.removeWhere((aluno) => aluno['uid'] == alunoId);

      // Atualizar a turma com a lista de alunos removida
      await turmaDoc.update({
        "alunos": alunos,
      });

      print('Aluno removido da turma com sucesso.');
    } catch (e) {
      print('Erro ao remover aluno da turma: $e');
    }
  }

  // Deletar Turma
  Future<void> deletarTurma(String turmaId) async {
    try {
      User? motorista = FirebaseAuth.instance.currentUser;

      if (motorista == null) {
        throw Exception('Motorista não autenticado.');
      }

      final turmaDoc =
          FirebaseFirestore.instance.collection('turmas').doc(turmaId);
      final turmaData = await turmaDoc.get();

      if (!turmaData.exists) {
        throw Exception('Turma não encontrada.');
      }

      // Verificar se o motorista logado é o proprietário da turma
      if (turmaData.data()?['motoristaId'] != motorista.uid) {
        throw Exception('Você não tem permissão para deletar esta turma.');
      }

      // Deletar a turma
      await turmaDoc.delete();

      print('Turma deletada com sucesso.');
    } catch (e) {
      print('Erro ao deletar turma: $e');
    }
  }

  // Função para buscar alunos com base em um termo de pesquisa
  Future<List<Map<String, dynamic>>> searchAlunos(String searchTerm) async {
    try {
      // Buscar alunos que tenham o nome contendo o termo de pesquisa
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('aluno')
          .where('nome', isGreaterThanOrEqualTo: searchTerm)
          .where('nome',
              isLessThanOrEqualTo: searchTerm + '\uf8ff') // Busca por prefixo
          .get();

      // Mapear os resultados para uma lista de mapas
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Erro ao buscar alunos: $e');
      return [];
    }
  }

  // Função para buscar turma com base em um termo de pesquisa
  Future<List<String>> fetchClasses(String motoristaId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('turmas') // Coleção 'turma'
          .where('motoristaId',
              isEqualTo: motoristaId) // Filtro pelo 'motoristaId'
          .get();

      // Se não houver documentos
      if (snapshot.docs.isEmpty) {
        return [];
      }

      // Mapeia os dados para uma lista de nomes das turmas
      return snapshot.docs
          .map((doc) => doc['nome'] as String) // 'className' é o nome da turma
          .toList();
    } catch (e) {
      print('Erro ao buscar as turmas: $e');
      return []; // Retorna lista vazia em caso de erro
    }
  }

  /// Busca os dados dos alunos de uma turma
  Future<List<Map<String, dynamic>>> fetchStudents(String classId) async {
    try {
      final classDoc = await FirebaseFirestore.instance
          .collection('turmas')
          .doc(classId)
          .get();

      if (!classDoc.exists) {
        throw Exception("Turma não encontrada");
      }

      final classData = classDoc.data();
      final List<String> studentIds =
          List<String>.from(classData!['alunos'] ?? []);

      List<Map<String, dynamic>> students = [];

      for (String alunoId in studentIds) {
        final alunoDoc = await FirebaseFirestore.instance
            .collection('aluno')
            .doc(alunoId)
            .get();

        if (alunoDoc.exists) {
          final alunoData = alunoDoc.data();
          students.add({
            "uid": alunoId,
            "nome": alunoData!['nome'],
          });
        }
      }

      return students;
    } catch (e) {
      print("Erro ao buscar alunos: $e");
      return [];
    }
  }
}

  Future<void> addAssinatura(String Assinatura, String NomeCondutor) async {
    try {

        CollectionReference assinatura = FirebaseFirestore.instance.collection('assinatura');

        await assinatura.doc().set({
          'nome': NomeCondutor,
          'assinatura': Assinatura,
        });

        print('Assinatura adicionada com sucesso');      
    } catch (e) {
      print('Erro ao adicionar assinatura: $e');
    }
  }


// if (isSideMenuOpen)
//                 Positioned(
//                   top: 50,
//                   left: 0,
//                   child: SideMenu(
//                     userName: userName, // Passe o nome do usuário
//                     avatarUrl: userProvider.user?.photoURL ??
//                         'https://via.placeholder.com/150', // Passe a URL do avatar
//                   ),
//                 ),

          // bottomNavigationBar: NavigationBarComplete(
          //   selectedIndex: _selectedIndex,
          //   onTap: _onItemTapped, // Alterado de onItemTapped para onTap
          // ),