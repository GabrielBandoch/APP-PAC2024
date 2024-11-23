import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
  // // teste
  // Future<String> addPayment() async {
  //   try {
  //     DocumentReference docRef =
  //         await FirebaseFirestore.instance.collection("Pagamento").add({
  //       'valor': '300',
  //     });

  //     String DocumentId = docRef.id;

  //     print("Pagamento realizado");
  //     return DocumentId;
  //   } catch (e) {
  //     print("Erro no pagamento");
  //     return "";
  //   }
  // }

  // Criando alunos e Crud
  Future<void> addAluno(String nomeE, String telefoneE, String numeroCasa,
      String nomeRua, String cidade, String estado, String cep) async {
    try {
      User? user = FirebaseAuth.instance
          .currentUser; //obter o usuário/resgitro atual para vincular a coleção
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
          'email': user.email, // Adiciona o e-mail do usuário
          'uid': user.uid, // Salva o UID para referência futura
          'role': 'aluno'
        });

        print('Aluno adicionado com sucesso');
      } else {
        print('Usuário não autenticado');
      }
    } catch (e) {
      print('Erro ao adicionar aluno: $e');
    }
  }

  // Criando condutor e Crud
  Future<void> addCondutor(String nomeC, String telefoneC) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        CollectionReference condutor =
            FirebaseFirestore.instance.collection('condutor');

        await condutor.doc(user.uid).set({
          'nomeC': nomeC,
          'telefoneC': telefoneC,
          'email': user.email,
          'uid': user.uid,
          'role': 'condutor'
        });

        print('Condutor adicionado com sucesso');
      } else {
        print('Usuario não autenticado');
      }
    } catch (e) {
      print('não foi possivel registrar o condutor');
    }
  }
}
