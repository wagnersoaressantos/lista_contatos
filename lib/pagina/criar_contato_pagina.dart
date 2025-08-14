import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_contatos/modelo/contato_modelo.dart';
import 'package:lista_contatos/repositorio/contato_repositorio.dart';
import 'package:lista_contatos/servicos/data_input_mascara.dart';
import 'package:lista_contatos/servicos/telefone_input_mascara.dart';

class CriarContatoPagina extends StatefulWidget {
  final String? objectoId;
  const CriarContatoPagina({super.key, this.objectoId});

  @override
  State<CriarContatoPagina> createState() => _CriarContatoPaginaState();
}

class _CriarContatoPaginaState extends State<CriarContatoPagina> {
  var contatoRepositorio = ContatoRepositorio();
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  bool carregando = false;
  bool editando = false;

  @override
  void initState() {
    super.initState();
    if (widget.objectoId != null) {
      editando = true;
      carregarContato(widget.objectoId);
    }
  }

  carregarContato(id) async {
    setState(() {
      carregando = true;
    });
    // var contato = await contatoRepositorio.buscarContato(id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Adicionar contato"), centerTitle: true),
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      context: context,
                      builder: (BuildContext bc) {
                        return Wrap(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              title: const Text("Camera"),
                              leading: const Icon(Icons.camera_alt),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              title: const Text("Galeria"),
                              leading: const Icon(Icons.insert_photo),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 40,
                    minRadius: 40,
                    backgroundColor: Colors.white,
                    child: Image.network(
                      "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                    ),
                  ),
                ),
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    label: Text(
                      "Nome:",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                TextField(
                  controller: dataController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    DataInputMascara(),
                    LengthLimitingTextInputFormatter(10),
                  ],

                  decoration: InputDecoration(
                    label: Text(
                      "Data de Nascimento:",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                TextField(
                  controller: telefoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TelefoneInputMascara()],
                  decoration: InputDecoration(
                    label: Text(
                      "Telefone:",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () async {
                    String localImagem = "past/teste.png";

                    if (nomeController.text.isEmpty ||
                        telefoneController.text.isEmpty ||
                        dataController.text.isEmpty) {
                      print("Preencha todos os campos!");
                      return;
                    }

                    await contatoRepositorio.salvar(
                      Contato.criar(
                        nomeController.text,
                        localImagem,
                        telefoneController.text,
                        dataController.text,
                      ),
                    );
                  },
                  child: Text("Salvar contato"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
