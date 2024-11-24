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