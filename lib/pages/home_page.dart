import 'dart:io';

import 'package:contatosapp/models/contatos_back4app.dart';
import 'package:contatosapp/pages/contatos_page.dart';
import 'package:contatosapp/repositories/contatos_back4app_repository.dart';
import 'package:contatosapp/shared/app_images.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  var _contatos = ContatosBack4App([]);
  var contatosBack4AppRepository = ContatosBack4AppRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterContatos();
  }

  void obterContatos() async {
    _contatos = await contatosBack4AppRepository.obterContatos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Contatos App")),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Contatos Cadastrados",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      ContatoBack4App contato = ContatoBack4App.vazio();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContatosPage(
                              contatoBack4App: contato,
                            ),
                          )).then((value) => obterContatos());
                    },
                    child: const Icon(Icons.person_add),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _contatos.contatos.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var contato = _contatos.contatos[index];
                          return Dismissible(
                            onDismissed:
                                (DismissDirection dismissDirection) async {
                              await contatosBack4AppRepository
                                  .remover(contato.objectId);
                              obterContatos();
                            },
                            key: Key(contato.objectId),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    contato.foto == ""
                                        ? Image.asset(
                                            width: 50,
                                            height: 50,
                                            AppImages.profile1,
                                          )
                                        : Image.file(
                                            width: 50,
                                            height: 50,
                                            File(contato.foto)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                          "Nome: ${contato.nome} - Telefone: ${contato.telefone}"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ContatosPage(
                                                contatoBack4App: contato,
                                              ),
                                            )).then((value) => obterContatos());
                                      },
                                      child: const Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
            ],
          )),
    ));
  }
}
