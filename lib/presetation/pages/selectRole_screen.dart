import 'package:flutter/material.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  _SelectRoleScreenState createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  bool isCondutorSelected = false;
  bool isAlunoSelected = false;
  String errorMessage = '';

  final TextEditingController condutorNameController = TextEditingController();
  final TextEditingController condutorPhoneController = TextEditingController();
  final TextEditingController alunoNameController = TextEditingController();
  final TextEditingController alunoPhoneController = TextEditingController();
  final TextEditingController alunoHouseNumberController =
      TextEditingController();
  final TextEditingController alunoStreetNameController =
      TextEditingController();
  final TextEditingController alunoCityController = TextEditingController();
  final TextEditingController alunoStateController = TextEditingController();
  final TextEditingController alunoZipCodeController = TextEditingController();

  final List<String> states = [
    'SC',
    'PR',
    'RJ',
    'SP',
    'MG',
    'BA',
    'RS',
    'ES',
    'PE',
    'CE'
  ];

  void selectCondutor() {
    setState(() {
      isCondutorSelected = true;
      isAlunoSelected = false;
      errorMessage = '';
    });
  }

  void selectAluno() {
    setState(() {
      isAlunoSelected = true;
      isCondutorSelected = false;
      errorMessage = '';
    });
  }

  void submit() {
    if (!isCondutorSelected && !isAlunoSelected) {
      setState(() {
        errorMessage = 'Por favor, selecione Condutor ou Responsável.';
      });
      return;
    }

    if (isCondutorSelected) {
      if (condutorNameController.text.isEmpty ||
          condutorPhoneController.text.isEmpty) {
        setState(() {
          errorMessage = 'Por favor, preencha todos os campos.';
        });
        return;
      }
    }

    if (isAlunoSelected) {
      if (alunoNameController.text.isEmpty ||
          alunoPhoneController.text.isEmpty ||
          alunoHouseNumberController.text.isEmpty ||
          alunoStreetNameController.text.isEmpty ||
          alunoCityController.text.isEmpty ||
          alunoStateController.text.isEmpty ||
          alunoZipCodeController.text.isEmpty) {
        setState(() {
          errorMessage = 'Por favor, preencha todos os campos.';
        });
        return;
      }
    }
    setState(() {
      errorMessage = '';
    });

    if (isCondutorSelected) {
      Navigator.pushNamed(context, '/home_driver');
    } else {
      Navigator.pushNamed(context, '/home_resp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Selecione',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectCondutor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isCondutorSelected ? Colors.blue : Colors.white,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      'Condutor',
                      style: TextStyle(
                        color: isCondutorSelected ? Colors.white : Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectAluno,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isAlunoSelected ? Colors.blue : Colors.white,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(
                      'Aluno',
                      style: TextStyle(
                        color: isAlunoSelected ? Colors.white : Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (isCondutorSelected) ...[
              TextField(
                controller: condutorNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Nome Completo do Condutor',
                  hintText: 'Digite o nome completo do condutor',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: condutorPhoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Telefone',
                  hintText: 'Digite o telefone do condutor',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ] else if (isAlunoSelected) ...[
              TextField(
                controller: alunoNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Nome Completo do Aluno',
                  hintText: 'Digite o nome completo do aluno',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: alunoPhoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Telefone',
                  hintText: 'Digite o telefone do aluno',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: alunoHouseNumberController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Número da Casa',
                  hintText: 'Digite o número da casa',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: alunoStreetNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Nome da Rua',
                  hintText: 'Digite o nome da rua',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: alunoCityController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Cidade',
                  hintText: 'Digite a cidade',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: alunoStateController.text.isEmpty
                    ? null
                    : alunoStateController.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'Estado',
                  hintText: 'Selecione o estado',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
                items: states.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    alunoStateController.text = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: alunoZipCodeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  labelText: 'CEP',
                  hintText: 'Digite o CEP',
                  hintStyle: const TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 30),
            Center(
              child: errorMessage.isNotEmpty
                  ? Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    )
                  : Container(),
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1577EA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'ENVIAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
