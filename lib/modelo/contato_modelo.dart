class ContatoModelo {
  List<Contato> results = [];

  ContatoModelo(this.results);

  ContatoModelo.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Contato>[];
      json['results'].forEach((v) {
        results.add(Contato.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Contato {
  String objectId = "";
  String nome = "";
  String localImagem = "";
  String telefone = "";
  String nascimento = "";
  String createdAt = "";
  String updatedAt = "";

  Contato(
    this.objectId,
    this.nome,
    this.localImagem,
    this.telefone,
    this.nascimento,
    this.createdAt,
    this.updatedAt,
  );
  Contato.criar(this.nome, this.localImagem, this.telefone, this.nascimento);

  Contato.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['nome'];
    localImagem = json['local_imagem'];
    telefone = json['telefone'];
    nascimento = json['nascimento'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['nome'] = nome;
    data['local_imagem'] = localImagem;
    data['telefone'] = telefone;
    data['nascimento'] = nascimento;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['local_imagem'] = localImagem;
    data['telefone'] = telefone;
    data['nascimento'] = nascimento;
    return data;
  }
}
