import 'package:flutter/material.dart';

class SelectRoleScreen extends StatefulWidget {
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
        errorMessage = 'Por favor, selecione Condutor ou Aluno.';
      });
      return;
    }

    if (isCondutorSelected) {
      if (condutorNameController.text.isEmpty || condutorPhoneController.text.isEmpty) {
        setState(() {
          errorMessage = 'Por favor, preencha todos os campos.';
        });
        return;
      }
    }

    if (isAlunoSelected) {
      if (alunoNameController.text.isEmpty || alunoPhoneController.text.isEmpty) {
        setState(() {
          errorMessage = 'Por favor, preencha todos os campos.';
        });
        return;
      }
    }

    // Ação do botão ENVIAR (enviar os dados ou seguir para outra tela)
    setState(() {
      errorMessage = '';
    });

    // Aqui você pode adicionar a lógica para processar os dados enviados
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
            SizedBox(height: 30),
            Text(
              'Selecione',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectCondutor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCondutorSelected ? Colors.blue : Colors.white,
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
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
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectAluno,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAlunoSelected ? Colors.blue : Colors.white,
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
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
            SizedBox(height: 30),
            if (isCondutorSelected) ...[
              TextField(
                controller: condutorNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  labelText: 'Nome Completo do Condutor',
                  hintText: 'Digite o nome completo do condutor',
                  hintStyle: TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: condutorPhoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  labelText: 'Telefone',
                  hintText: 'Digite o telefone do condutor',
                  hintStyle: TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
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
                  fillColor: Color(0xFFF5F5F5),
                  labelText: 'Nome Completo do Aluno',
                  hintText: 'Digite o nome completo do aluno',
                  hintStyle: TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: alunoPhoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  labelText: 'Telefone',
                  hintText: 'Digite o telefone do aluno',
                  hintStyle: TextStyle(color: Color(0xFFBCBCBC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xFF1577EA),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 30),
            Center(
              child: errorMessage.isNotEmpty 
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container(), // Retorna um Container vazio se não houver mensagem de erro
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1577EA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
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
