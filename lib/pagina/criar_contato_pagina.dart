import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_contatos/modelo/contato_modelo.dart';
import 'package:lista_contatos/repositorio/contato_repositorio.dart';
import 'package:lista_contatos/servicos/data_input_mascara.dart';
import 'package:lista_contatos/servicos/telefone_input_mascara.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

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
  String? caminhoImagem;

  @override
  void initState() {
    super.initState();
    if (widget.objectoId != null) {
      editando = true;
      carregarContato(widget.objectoId);
    }
  }

  Future<void> carregarContato(id) async {
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
                              onTap: () async {
                                Navigator.pop(context);
                                final ImagePicker picker = ImagePicker();
                                final XFile? photo = await picker.pickImage(
                                  source: ImageSource.camera,
                                );
                                if (photo != null) {
                                  String path =
                                      (await path_provider
                                              .getApplicationDocumentsDirectory())
                                          .path;
                                  String nome = basename(photo.path);
                                  var caminho = "$path/$nome";
                                  await photo.saveTo("$path/$nome");
                                  setState(() {
                                    caminhoImagem = caminho;
                                  });
                                }
                              },
                              title: const Text("Camera"),
                              leading: const Icon(Icons.camera_alt),
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
                    child: caminhoImagem != null
                        ? ClipOval(
                            child: Image.file(
                              File(caminhoImagem!),
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          )
                        : Icon(Icons.person),
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
                    String localImagem = caminhoImagem ?? "Erro no arquivo";

                    if (nomeController.text.isEmpty ||
                        telefoneController.text.isEmpty ||
                        dataController.text.isEmpty) {
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
                    Navigator.pop(context);
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
