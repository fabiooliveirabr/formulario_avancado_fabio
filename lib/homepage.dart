//homepage.dart
import 'package:flutter/material.dart';

//Criar um Widget do tipo Scaffold
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Esse comando criar o ID do formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _submitForm() {
  if (_formKey.currentState!.validate()) {
  // Fazer alguma ação depois de validar
  print('Está tudo certo');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("FORMULÁRIO AVANÇADO"),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  //-----------------------------
                  TextFormField(
                    validator: (value) => _validateEmail(value.toString()),
                    decoration: InputDecoration(
                      label: Text("E-mail"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  //-----------------------------
                  ElevatedButton(
                    onPressed: (){ _submitForm();}, 
                    child: Text("Enviar"),),
                  //-----------------------------
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



String? _validateEmail(String texto) {
//Verificar se está vazio
if (texto.isEmpty) {
return 'Por favor, insira um email.';
}
//Verificar se não o @
if (!texto.contains('@') || !texto.contains(".")) {
return 'Por favor, insira um email válido.';
}
//Verificar se tem espaços
if (texto.contains(' ')){
return 'Por favor, não coloque espaços em branco.';
}
//Se estiver tudo certo retorna null
return null;
}

