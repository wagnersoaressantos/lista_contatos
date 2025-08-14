import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lista_contatos/pagina/inicial_pagina.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(InicialPagina());
}
