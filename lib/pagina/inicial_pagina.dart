import 'package:flutter/material.dart';
import 'package:lista_contatos/pagina/menu_pagina.dart';

class InicialPagina extends StatefulWidget {
  const InicialPagina({super.key});

  @override
  State<InicialPagina> createState() => _InicialPaginaState();
}

class _InicialPaginaState extends State<InicialPagina> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.green[100]),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
          accentColor: Colors.blue[300],
        ),
      ),
      home: MenuPagina(),
    );
  }
}
