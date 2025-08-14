import 'package:flutter/material.dart';
import 'package:lista_contatos/compartilhado/imagem_padrao.dart';
import 'package:lista_contatos/pagina/criar_contato_pagina.dart';
import 'package:lista_contatos/pagina/lista_contato_pagina.dart';

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
          color: Colors.blue,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CriarContatoPagina(),
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Expanded(child: Container()),
                              Expanded(
                                flex: 1,
                                child: Image.asset(ImagemPadrao.criar_contato),
                              ),
                              // Expanded(child: Container()),
                              Text("Criar Contato"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaContatoPagina(),
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(ImagemPadrao.lista_contato),
                              ),
                              Text("Lista de Contato"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
