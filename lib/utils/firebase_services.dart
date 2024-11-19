import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  Future<String> addPayment() async {
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection("Pagamento").add({
        'valor': '300',
      });

      String DocumentId = docRef.id;

      print("Pagamento realizado");
      return DocumentId;
    } catch (e) {
      print("Erro no pagamento");
      return "";
    }
  }
}
