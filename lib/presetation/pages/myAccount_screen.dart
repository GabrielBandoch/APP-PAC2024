import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/userGretting.dart';
import 'package:pac20242/presetation/widgets/navigationBarComplete.dart';
import 'package:pac20242/presetation/widgets/sideMenu.dart';
import 'package:pac20242/utils/firebase_services.dart';
import 'package:provider/provider.dart';
import 'package:pac20242/Provider/userProvider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4;
  bool isSideMenuOpen = false;
  bool isLoading = true;
  late Map<String, dynamic> userData;
  final FireStoreServices _firestoreServices = FireStoreServices();
  late String userRole;
  late String userId;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numeroCasaController = TextEditingController();
  final TextEditingController nomeRuaController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController cepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userId = userProvider.user!.uid;
    userRole = userProvider.userRole ?? 'aluno';

    // Buscar dados do aluno ou condutor
    if (userRole == 'aluno') {
      userData = await _firestoreServices.getAlunoData(userId) ?? {};
    } else {
      userData = await _firestoreServices.getCondutorData(userId) ?? {};
    }

    setState(() {
      isLoading = false;
      nomeController.text = userData['nome'] ?? '';
      telefoneController.text = userData['telefone'] ?? '';
      emailController.text = userData['email'] ?? '';
      numeroCasaController.text = userData['numeroCasa'] ?? '';
      nomeRuaController.text = userData['nomeRua'] ?? '';
      cidadeController.text = userData['cidade'] ?? '';
      estadoController.text = userData['estado'] ?? '';
      cepController.text = userData['cep'] ?? '';
    });
  }

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

  void _deleteAccount() async {
    // Armazena o contexto principal (fora do diálogo)
    final mainContext = context;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Tem certeza que deseja deletar sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Fecha o diálogo
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Fecha o diálogo antes de continuar

                try {
                  // Acesse o Provider antes de qualquer navegação
                  final userProvider =
                      Provider.of<UserProvider>(mainContext, listen: false);
                  String userId = userProvider.user!.uid;
                  String userRole = userProvider.userRole ?? 'aluno';

                  // Excluir conta e dados do Firestore
                  await _firestoreServices.deleteAccount(userId, userRole);

                  // Excluir a conta do Firebase Authentication
                  await FirebaseAuth.instance.signOut();

                  // Usa o contexto principal (fora do diálogo) para navegar
                  if (mainContext.mounted) {
                    Navigator.pushReplacementNamed(mainContext, '/login');
                  }

                  ScaffoldMessenger.of(mainContext).showSnackBar(
                    const SnackBar(
                        content: Text('Conta deletada com sucesso.')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(mainContext).showSnackBar(
                    SnackBar(content: Text('Erro ao excluir conta: $e')),
                  );
                }
              },
              child: const Text('Deletar'),
            ),
          ],
        );
      },
    );
  }

  void _saveChanges() async {
    try {
      userData['nome'] = nomeController.text;
      userData['telefone'] = telefoneController.text;
      userData['email'] = emailController.text;
      userData['numeroCasa'] = numeroCasaController.text;
      userData['nomeRua'] = nomeRuaController.text;
      userData['cidade'] = cidadeController.text;
      userData['estado'] = estadoController.text;
      userData['cep'] = cepController.text;

      if (userRole == 'aluno') {
        await _firestoreServices.updateAluno(userId, userData);
      } else {
        await _firestoreServices.updateCondutor(userId, userData);
      }

      _loadUserData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados atualizados com sucesso.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar dados: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final userName =
            userProvider.user?.displayName ?? 'Nome não disponível';
        final userEmail = userProvider.user?.email ?? 'Email não disponível';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Perfil'),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: toggleSideMenu,
              ),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 55),
                      UserGreeting(
                        userName: userName,
                        avatarUrl: userProvider.user?.photoURL ??
                            'https://via.placeholder.com/150',
                        onAvatarTap: toggleSideMenu,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userEmail,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Editar informações',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator()
                          : userRole == 'condutor'
                              ? _buildCondutorFields()
                              : _buildAlunoFields(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/esenha');
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                side: const BorderSide(
                                    color: Color(0xFF1577EA), width: 2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Esqueceu sua senha?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1577EA),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _deleteAccount,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Deletar conta',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: _saveChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1577EA),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Salvar',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                            side: const BorderSide(
                                color: Color(0xFF1577EA), width: 2),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Voltar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1577EA),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isSideMenuOpen)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: toggleSideMenu,
                    child: Container(color: Colors.black54),
                  ),
                ),
              if (isSideMenuOpen)
                Positioned(
                  top: 50,
                  left: 0,
                  child: SideMenu(
                    userName: userName, // Passe o nome do usuário
                    avatarUrl: userProvider.user?.photoURL ??
                        'https://via.placeholder.com/150', // Passe a URL do avatar
                  ),
                ),
            ],
          ),
          bottomNavigationBar: NavigationBarComplete(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped, // Alterado de onItemTapped para onTap
          ),
        );
      },
    );
  }

  Widget _buildAlunoFields() {
    return Column(
      children: [
        _buildTextField('Nome', nomeController),
        _buildTextField('Telefone', telefoneController),
        _buildTextField('Email', emailController),
        _buildTextField('Número da casa', numeroCasaController),
        _buildTextField('Nome da rua', nomeRuaController),
        _buildTextField('Cidade', cidadeController),
        _buildTextField('Estado', estadoController),
        _buildTextField('CEP', cepController),
      ],
    );
  }

  Widget _buildCondutorFields() {
    return Column(
      children: [
        _buildTextField('Nome', nomeController),
        _buildTextField('Telefone', telefoneController),
        _buildTextField('Email', emailController),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
