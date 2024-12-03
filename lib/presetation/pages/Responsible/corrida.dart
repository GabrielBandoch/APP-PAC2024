import 'package:flutter/material.dart';

class StudentLocationScreen extends StatefulWidget {
  const StudentLocationScreen({super.key});

  @override
  _StudentLocationScreenState createState() => _StudentLocationScreenState();
}

class _StudentLocationScreenState extends State<StudentLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localização do Aluno'), // Você pode adicionar um título aqui
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16), // Espaçamento inicial
          UserHeader(
            userName: 'Francisco',
            avatarUrl: 'https://via.placeholder.com/150',
            onAvatarTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Avatar tocado!')),
              );
            },
          ),
          const SizedBox(height: 60), // Espaçamento entre o header e o texto
          const Text(
            'Localização em tempo real do aluno',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 100),
          const Icon(
            Icons.location_on, // Ícone de localização do Material Design
            size: 250.0,
            color: Colors.orange, // Cor do ícone
          ),
          const SizedBox(height: 90),
          const Text(
            'Aluno está a 2Km de distância do destino',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60), // Pequeno espaçamento entre o texto e o botão
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 35),
            child: SizedBox(
              width: 320,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Ação do botão "Voltar"
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
    );
  }
}

class UserHeader extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final VoidCallback onAvatarTap;

  const UserHeader({
    Key? key,
    required this.userName,
    required this.avatarUrl,
    required this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1577EA),
          width: 2,
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onAvatarTap,
              child: CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 24,
              ),
            ),
          ),
          Text(
            'Olá, $userName',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
