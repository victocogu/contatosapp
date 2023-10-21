class ContatosBack4App {
  List<ContatoBack4App> contatos = [];

  ContatosBack4App(this.contatos);

  ContatosBack4App.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <ContatoBack4App>[];
      json['results'].forEach((v) {
        contatos.add(ContatoBack4App.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = contatos.map((v) => v.toJson()).toList();
    return data;
  }
}

class ContatoBack4App {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  String nome = "";
  String telefone = "";
  String foto = "";

  ContatoBack4App(this.objectId, this.createdAt, this.updatedAt, this.nome,
      this.telefone, this.foto);

  ContatoBack4App.criar(this.nome, this.telefone, this.foto);

  ContatoBack4App.vazio();

  ContatoBack4App.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    nome = json['Nome'];
    telefone = json['Telefone'];
    foto = json['Foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['Nome'] = nome;
    data['Telefone'] = telefone;
    data['Foto'] = foto;
    return data;
  }

  Map<String, dynamic> toJsonEndPoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Nome'] = nome;
    data['Telefone'] = telefone;
    data['Foto'] = foto;
    return data;
  }
}
