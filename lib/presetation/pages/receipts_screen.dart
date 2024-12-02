import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/presetation/widgets/receipts.dart';
import 'package:pac20242/utils/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pac20242/Provider/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  _ReceiptsScreenState createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {

    @override
  void initState() {
    super.initState();
    _getUserData();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.initializeUser(FirebaseAuth.instance.currentUser!);
    userProvider.addListener(_fetchReceipts);
  }

  List<Map<String, dynamic>> receipts = [];

  bool isSideMenuOpen = false;
  String userName = "Carregando...";
  final String avatarUrl = "";

  Future<void> _getUserData() async {
  final String? userId = await AuthService.getCurrentUserId();  // Pegando o ID do usuário logado
  if (userId != null) {
    try {
      // Buscando dados do usuário no Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('aluno')  // Coleção de usuários no Firestore
          .doc(userId)  // Usando o ID do usuário como documento
          .get();

      // Verifica se o widget ainda está montado antes de chamar setState
      if (mounted) {
        if (userDoc.exists) {
          String fullName = userDoc['nome'] ?? "Nome não encontrado";  // Pega o nome completo
          userName = fullName.split(' ').first;  // Pega o primeiro nome
        } else {
          userName = "Usuário não encontrado";
        }
        setState(() {});  // Atualiza o estado
      }
    } catch (e) {
      print('Erro ao buscar usuário: $e');
      if (mounted) {
        userName = "Erro ao carregar dados";
        setState(() {});  // Atualiza o estado com o erro
      }
    }
  } else {
    if (mounted) {
      userName = "Não logado";  // Caso o usuário não esteja logado
      setState(() {});  // Atualiza o estado
    }
  }
}


  Future<void> _fetchReceipts() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userRole = userProvider.userRole;
    final userId = userProvider.uid;

    if (userRole == null || userId == null) return;

    try {
      QuerySnapshot snapshot;

      if (userRole == "aluno") {
        // A consulta está filtrando por aluno corretamente
        snapshot = await FirebaseFirestore.instance
            .collection('recibos')
            .where('aluno', isEqualTo: userProvider.user?.displayName)
            .get();
      } else {
        // Condutor pode ver pagamentos com base no seu ID
        snapshot = await FirebaseFirestore.instance
            .collection('recibos')
            .where('condutorId', isEqualTo: userId)
            .get();
      }

      setState(() {
        receipts = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      debugPrint('Erro ao buscar recibos: $e');
    }
  }

  void toggleSideMenu() {
    setState(() {
      isSideMenuOpen = !isSideMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 55),
              UserGreeting(
                userName: userName,
                avatarUrl: avatarUrl,
                onAvatarTap: toggleSideMenu,
              ),
              const SizedBox(height: 30),
                                Expanded(
                    child: ListView.builder(
                      itemCount: receipts.length,
                      itemBuilder: (context, index){
                        final receipt = receipts[index];
                        final status = receipt['status'] ?? 'Pendente';
                        final date = receipt['data'] ?? '';
                        final amount = receipt['valor']?.toDouble() ?? 0.0;
                        final uid = receipt['uid'] ?? '';

                        return ReceiptCard(
                          userName: receipt['aluno'].split(' ').first ?? 'Aluno Desconhecido',
                          avatarUrl: '',
                          status: status,
                          date: date,
                          amount: 'R\$ ${amount}',
                          uid: uid,
                        );
                      },
                    )
                  ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 35),
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1577EA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isSideMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: toggleSideMenu,
                child: Container(
                  color: Colors.black54,
                ),
              ),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: isSideMenuOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: SideMenu(
              userName: userName,
              avatarUrl: avatarUrl,
            ),
          ),
        ],
      ),
    );
  }
  
}
