import 'package:flutter/material.dart';

class MenuPagina extends StatefulWidget {
  const MenuPagina({super.key});

  @override
  State<MenuPagina> createState() => _MenuPaginaState();
}

class _MenuPaginaState extends State<MenuPagina> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Contatos"), centerTitle: true),
        body: Container(
          color: Colors.blue[50],
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(children: [Text("Criar Contato")]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [Text("Lista de Contato")],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
