import 'package:flutter/material.dart';
import 'package:lista_contatos/modelo/contato_modelo.dart';
import 'package:lista_contatos/repositorio/contato_repositorio.dart';

class ListaContatoPagina extends StatefulWidget {
  const ListaContatoPagina({super.key});

  @override
  State<ListaContatoPagina> createState() => _ListaContatoPaginaState();
}

class _ListaContatoPaginaState extends State<ListaContatoPagina> {
  ContatoRepositorio contatoRepositorio = ContatoRepositorio();
  var listaContato = ContatoModelo([]);

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  carregarContatos() async {
    listaContato = await contatoRepositorio.listaContato();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("lista de contatos"), centerTitle: true),

        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: listaContato.results.isEmpty
            ? Center(child: Text("nenhum contato registrado"))
            : ListView.builder(
                itemCount: listaContato.results.length,
                itemBuilder: (context, index) {
                  var contato = listaContato.results[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await contatoRepositorio.remover(contato.objectId);
                      carregarContatos();
                    },
                    key: Key(contato.objectId),
                    child: GestureDetector(
                      onTap: () {
                        print('edita ${contato.objectId}');
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(child: Icon(Icons.person)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person),
                                      Text(contato.nome),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(contato.nascimento),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone_android),
                                      Text(contato.telefone),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
