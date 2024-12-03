import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/navigationBarReduced.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/presetation/widgets/statusCard.dart';
import 'package:pac20242/utils/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Exemplo de como os dados do pagamento podem ser estruturados
class Payment {
  final String aluno;
  final String status;
  final String date;
  final double value;

  Payment({
    required this.aluno,
    required this.status,
    required this.date,
    required this.value,
  });
}

class HomeScreenResponsavel extends StatefulWidget {
  const HomeScreenResponsavel({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenResponsavel> {

  @override
  void initState() {
    super.initState();
    _getUserData();
    // Carregar pagamentos fictícios
    fetchPayments();
  }

  String userName = "Carregando...";  
  String avatarUrl = "";

  Future<void> _getUserData() async {
  final String? userId = await AuthService.getCurrentUserId();  // Pegando o ID do usuário logado
  if (userId != null) {
    try {
      // Buscando dados do usuário no Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('condutor')  // Coleção de usuários no Firestore
          .doc(userId)  // Usando o ID do usuário como documento
          .get();


      // Verifica se o widget ainda está montado antes de chamar setState
      if (mounted) {
        if (userDoc.exists) {
          String fullName = userDoc['nome'] ?? "Nome não encontrado";  // Pega o nome completo
          userName = fullName.split(' ').first;  // Pega o primeiro nome
        } else {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('aluno')  // Coleção de usuários no Firestore
            .doc(userId)  // Usando o ID do usuário como documento
            .get();

            if(userDoc.exists){
              String fullName = userDoc['nome'] ?? "Nome não encontrado";  // Pega o nome completo
              userName = fullName.split(' ').first;  // Pega o primeiro nome
            } else{
              print("NÂO TEM NADA AI");
            }
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

  int _selectedIndex = 2;
  bool isSideMenuOpen = false;
  
  // Lista fictícia de pagamentos, como exemplo
  List<Payment> payments = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleSideMenu() {
    setState(() {
      isSideMenuOpen = !isSideMenuOpen;
    });
  }

  // Simulando a busca de pagamentos
  void fetchPayments() {
    // Adicionando pagamentos fictícios
    setState(() {
      payments = [
        Payment(
          aluno: "Gabriel",
          status: "Pago",
          date: "01/01/2024",
          value: 100.00,
        ),
        Payment(
          aluno: "Gabriel",
          status: "Pendente",
          date: "02/01/2024",
          value: 200.00,
        ),
        Payment(
          aluno: "Gabriel",
          status: "Atrasado",
          date: "03/01/2024",
          value: 150.00,
        ),
      ];
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildIconButton(
                    'Pagamentos',
                    Icons.attach_money,
                    () {
                      Navigator.pushNamed(context, '/payment');
                    },
                  ),
                  buildIconButton(
                    'Recibos',
                    Icons.receipt_long,
                    () {
                      Navigator.pushNamed(context, '/recibos');
                    },
                  ),
                  buildIconButton(
                    'Corrida',
                    Icons.location_on,
                    () {
                      Navigator.pushNamed(context, '/corridaAluno');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: payments.map((payment) {
                      return StatusCard(
                        userName: payment.aluno,
                        avatarUrl: '',
                        status: payment.status,
                        date: payment.date,
                        value: payment.value,
                      );
                    }).toList(),
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
      bottomNavigationBar: NavigationBarReduced(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildIconButton(String label, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1577EA), width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
