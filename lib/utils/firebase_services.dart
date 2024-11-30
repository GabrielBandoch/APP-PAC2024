import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
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

  // Criar turma vinculada ao motorista logado
  Future<void> criarTurma(
      String nomeTurma, List<String> alunosSelecionados) async {
    try {
      User? motorista = FirebaseAuth.instance.currentUser;

      if (motorista == null) {
        throw Exception('Motorista não autenticado.');
      }

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

      // Criar a turma com o ID do motorista associado
      await turmaDoc.set({
        "id": turmaDoc.id,
        "nome": nomeTurma,
        "motoristaId": motorista.uid,
        "alunos": alunosComEndereco,
        "criadoEm": FieldValue.serverTimestamp(),
      });

      print(
          'Turma criada com sucesso e vinculada ao motorista ${motorista.uid}.');
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

  // Remover Aluno
  Future<void> removerAlunoDaTurma(String turmaId, String alunoId) async {
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

      if (turmaData.data()?['motoristaId'] != motorista.uid) {
        throw Exception('Você não tem permissão para modificar esta turma.');
      }

      List<dynamic> alunos = turmaData.data()?['alunos'] ?? [];
      alunos.removeWhere((aluno) => aluno['uid'] == alunoId);

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

      if (turmaData.data()?['motoristaId'] != motorista.uid) {
        throw Exception('Você não tem permissão para deletar esta turma.');
      }

      await turmaDoc.delete();

      print('Turma deletada com sucesso.');
    } catch (e) {
      print('Erro ao deletar turma: $e');
    }
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