//homepage.dart
import 'package:flutter/material.dart';

//Criar um Widget do tipo Scaffold
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;
  DateTime dataSelecionada = DateTime.now();
  String _opcaoPadrao = "Selecione";
  List<String> _listaOpcoes = ["Selecione", "Opção 1", "Opção 2", "Opção 3"];
  bool _opRecife = false;
  bool _opJaboatao = false;
  bool _opCabo = false;
  Color corDaMensagem = Colors.transparent;
  Color corDaMensagem2 = Colors.transparent;

  String _opcaoEscolhida = "";
  List<String> _outraLista = ["A+", "A-", "O-", "AB+"];

  Future<void> _escolherData(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dataSelecionada)
      setState(() {
        dataSelecionada = picked;
      });
  }

  //Esse comando criar o ID do formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_opcaoEscolhida == "") {
      setState(() {
        corDaMensagem2 = Colors.red;
      });
    } else {
      setState(() {
        corDaMensagem2 = Colors.transparent;
      });
    }

    if (_opRecife == false && _opCabo == false && _opJaboatao == false) {
      setState(() {
        corDaMensagem = Colors.red;
      });
    } else {
      setState(() {
        corDaMensagem = Colors.transparent;
      });
      //Exibir o conteúdo das variáveis
      print("$email");
      print("$dataSelecionada");
      print("Recife: $_opRecife");
      print("Cabo de Santo Agostinho: $_opCabo");
      print("Jaboatão: $_opJaboatao");
      print("$_opcaoPadrao");
      print("$_opcaoEscolhida");
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "FORMULÁRIO AVANÇADO",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //-----------------------------
                    TextFormField(
                      onChanged: (value) => email = value,
                      validator: (value) => _validateEmail(value.toString()),
                      decoration: InputDecoration(
                        label: Text("E-mail"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    //-----------------------------
                    SizedBox(height: 10),
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
                        border: OutlineInputBorder(),
                        labelText: 'Opções',
                      ),
                    ),
                    //-----------------------------
                    SizedBox(height: 20),
                    Text(
                      "Escolha uma(s) cidade(s)",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                   Text(
                      "Selecione pelo menos uma cidade",
                      style: TextStyle(color: corDaMensagem),
                    ),
                    //-----------------------------
                     Text(
                      "Escolha um tipo sanguíneo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //-----------------------------

                    Column(
                      children: _outraLista.map((cursos) {
                        return RadioListTile(
                          title: Text(cursos),
                          value: cursos,
                          groupValue: _opcaoEscolhida,
                          onChanged: (value) {
                            setState(() {
                              _opcaoEscolhida = value.toString();
                            });
                          },
                        );
                      }).toList(),
                    ),

                    Text(
                      "Por favor, selecione um tipo sanguíneo",
                      style: TextStyle(color: corDaMensagem2),
                    ),

                    //-----------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${dataSelecionada.toLocal()}".split(' ')[0]),
                        ElevatedButton(
                          onPressed: () => _escolherData(context),
                          child: Text("Escolha uma data"),
                        ),
                      ],
                    ),
                    //-----------------------------
                    SizedBox(height: 10),
                    //-----------------------------
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text("Enviar"),
                    ),
                    //-----------------------------
                  ],
                ),
              ),
            ],
          ),
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
  if (texto.contains(' ')) {
    return 'Por favor, não coloque espaços em branco.';
  }
//Se estiver tudo certo retorna null
  return null;
}

//Criar método para validar o ComboBox
String? _validarComboBox(String texto) {
  if (texto == "Selecione") {
    return "Por favor, selecione uma opção";
  }
  return null;
}
