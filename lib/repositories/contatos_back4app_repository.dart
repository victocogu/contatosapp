import 'package:contatosapp/models/contatos_back4app.dart';
import 'package:contatosapp/repositories/back4app_custom_dio.dart';

class ContatosBack4AppRepository {
  final _custonDio = Back4AppCustonDio();

  Future<ContatosBack4App> obterContatos() async {
    var url = "/Contatos";

    var result = await _custonDio.dio.get(url);
    return ContatosBack4App.fromJson(result.data);
  }

  Future<void> criar(ContatoBack4App contatoBack4App) async {
    try {
      await _custonDio.dio
          .post("/Contatos", data: contatoBack4App.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(ContatoBack4App contatoBack4App) async {
    try {
      await _custonDio.dio.put("/Contatos/${contatoBack4App.objectId}",
          data: contatoBack4App.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete("/Contatos/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
