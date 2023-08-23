//homepage.dart
import 'package:flutter/material.dart';

//Criar um Widget do tipo Scaffold
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _opcaoPadrao = "Selecione";
  List<String> _listaOpcoes = 
  ["Selecione", "Opção 1", "Opção 2", "Opção 3"];
  bool _opRecife = false;
  bool _opJaboatao = false;
  bool _opCabo = false;
  Color corDaMensagem = Colors.transparent;


  //Esse comando criar o ID do formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  void _submitForm() {
    if(_opRecife == false && _opCabo == false && _opJaboatao == false){
        setState(() {
           corDaMensagem = Colors.red;
        });
    }else{
        setState(() {
           corDaMensagem = Colors.transparent;
        });
    }

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
                  DropdownButtonFormField<String>(
                    validator: (value) => _validarComboBox(value.toString()),
                    value: _opcaoPadrao,
                    onChanged: (novoValor) {
                    setState(() {
                    _opcaoPadrao = novoValor.toString();
                    });
                    },
                    items: _listaOpcoes.map((opcao) {
                    return DropdownMenuItem<String>(
                    value: opcao,
                    child: Text(opcao),
                    );
                    }).toList(),
                    decoration: InputDecoration(
                    labelText: 'Opções',
                    ),
                    ),
                //-----------------------------

                CheckboxListTile(
                  title: Text('Recife'),
                  value: _opRecife,
                  onChanged: (bool? value) {
                  setState(() {
                  _opRecife = value!;
                  });
                  },
                  ),
                  CheckboxListTile(
                  title: Text('Jaboatão'),
                  value: _opJaboatao,
                  onChanged: (bool? value) {
                  setState(() {
                  _opJaboatao = value!;
                  });
                  },
                  ),
                  CheckboxListTile(
                  title: Text('Cabo de Santo Agostinho'),
                  value: _opCabo,
                  onChanged: (bool? value) {
                  setState(() {
                  _opCabo = value!;
                  });
                  },
                  ),

                
                //-----------------------------
                Text("Selecione pelo menos uma cidade",
                  style: TextStyle(color: corDaMensagem),
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

//Criar método para validar o ComboBox
String? _validarComboBox(String texto){
    if(texto == "Selecione"){
        return "Por favor, selecione uma opção";
    }
    return null;
}