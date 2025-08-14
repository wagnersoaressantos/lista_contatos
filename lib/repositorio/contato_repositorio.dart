import 'package:dio/dio.dart';
import 'package:lista_contatos/modelo/contato_modelo.dart';
import 'package:lista_contatos/repositorio/custom_repositorio.dart';

class ContatoRepositorio {
  final _dio = CustomRepositorio();
  ContatoRepositorio();

  Future<ContatoModelo> listaContato() async {
    var url = "/contato";
    var results = await _dio.dio.get(url);
    if (results.statusCode == 200) {
      return ContatoModelo.fromJson(results.data);
    }
    return ContatoModelo([]);
  }

  Future<ContatoModelo> buscarContato(String objectId) async {
    var url = "/contato";
    url = "$url?where ={\"objectId\":\"$objectId\"}";
    var results = await _dio.dio.get(url);
    if (results.statusCode == 200) {  
      return ContatoModelo.fromJson(results.data);
    }
    return ContatoModelo([]);
  }

  Future<void> salvar(Contato contato) async {
    try {
      final payload = contato.toJsonEndpoint();
      print('Payload enviado: $payload');

      var response = await _dio.dio.post("/contato", data: payload);
      print('Resposta: ${response.data}');
    } on DioException catch (e) {
      print('Status: ${e.response?.statusCode}');
      print('Erro: ${e.response?.data}');
    }
  }

  Future<void> remover(String objectId) async {
    await _dio.dio.delete("/contato/$objectId");
  }
}
