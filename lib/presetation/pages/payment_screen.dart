import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pac20242/presetation/widgets/navigationBarComplete.dart';
import 'package:pac20242/presetation/widgets/navigationBarReduced.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/presetation/widgets/statusCard.dart';
import 'package:provider/provider.dart';
import 'package:pac20242/Provider/userProvider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedIndex = 2;
  bool isSideMenuOpen = false;
  List<Map<String, dynamic>> payments = [];
  List<String> allStudents = [];
  String? selectedStudent;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.initializeUser(FirebaseAuth.instance.currentUser!);
    userProvider.addListener(_fetchPayments);
    _fetchAllStudents();
  }

  Future<void> _fetchAllStudents() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('aluno').get();
      List<String> alunos =
          snapshot.docs.map((doc) => doc['nome'] as String).toList();

      setState(() {
        allStudents = alunos;
      });
    } catch (e) {
      debugPrint('Erro ao buscar alunos: $e');
    }
  }

  // Fetches payments based on user role (student or condutor)
  Future<void> _fetchPayments() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userRole = userProvider.userRole;
    final userId = userProvider.uid;

    if (userRole == null || userId == null) return;

    try {
      QuerySnapshot snapshot;

      if (userRole == "aluno") {
        // A consulta está filtrando por aluno corretamente
        snapshot = await FirebaseFirestore.instance
            .collection('pagamentos')
            .where('aluno', isEqualTo: userProvider.user?.displayName)
            .get();
      } else {
        // Condutor pode ver pagamentos com base no seu ID
        snapshot = await FirebaseFirestore.instance
            .collection('pagamentos')
            .where('condutorId', isEqualTo: userId)
            .get();
      }

      setState(() {
        payments = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      debugPrint('Erro ao buscar pagamentos: $e');
    }
  }

  Future<void> _createPayment() async {
    if (selectedStudent == null ||
        _dateController.text.isEmpty ||
        _valueController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Selecione um aluno, insira a data e o valor do pagamento."),
        ),
      );
      return;
    }

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await FirebaseFirestore.instance.collection('pagamentos').add({
        'aluno': selectedStudent,
        'status': 'Pendente',
        'data': _dateController.text.trim(),
        'valor': double.tryParse(_valueController.text.trim()) ?? 0.0,
        'condutorId': userProvider.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pagamento criado com sucesso!")),
      );
      _fetchPayments();
    } catch (e) {
      debugPrint("Erro ao criar pagamento: $e");
    }
  }

  // Handles bottom navigation tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Toggles the side menu visibility
  void toggleSideMenu() {
    setState(() {
      isSideMenuOpen = !isSideMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userRole = userProvider.userRole;
    final userName = userProvider.user?.displayName ?? "Usuário";

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 55),
              UserGreeting(
                userName: userName,
                avatarUrl: '',
                onAvatarTap: toggleSideMenu,
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Pagamentos',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 34, 18),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (userRole == "condutor")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () => _showCreatePaymentModal(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue, width: 2),
                    ),
                    child: const Text(
                      "Criar Pagamento",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    final payment = payments[index];
                    final status = payment['status'] ?? 'Pendente';
                    final paymentDate = payment['data'] ?? '';
                    final value = payment['valor']?.toDouble() ?? 0.0;

                    return StatusCard(
                      userName: payment['aluno'] ?? 'Aluno Desconhecido',
                      avatarUrl: '',
                      status: status,
                      date: paymentDate,
                      value: value,
                    );
                  },
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
              avatarUrl: '',
            ),
          ),
        ],
      ),
      bottomNavigationBar: userRole == 'aluno'
          ? NavigationBarReduced(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            )
          : NavigationBarComplete(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
    );
  }

  // Displays the modal to create a new payment
  void _showCreatePaymentModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Criar Pagamento",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: "Buscar Aluno",
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedStudent = allStudents.firstWhere(
                        (student) =>
                            student.toLowerCase().contains(value.toLowerCase()),
                        orElse: () => '');
                  });
                },
              ),
              if (selectedStudent != null && selectedStudent!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Aluno Selecionado: $selectedStudent",
                      style: TextStyle(fontSize: 16)),
                ),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: "Data do Pagamento (DD/MM/YYYY)",
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _valueController,
                decoration: const InputDecoration(
                  labelText: "Valor",
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Criar"),
              onPressed: () {
                _createPayment();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
