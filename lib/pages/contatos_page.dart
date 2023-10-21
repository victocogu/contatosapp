import 'dart:io';
import 'package:contatosapp/models/contatos_back4app.dart';
import 'package:contatosapp/repositories/contatos_back4app_repository.dart';
import 'package:contatosapp/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ContatosPage extends StatefulWidget {
  final ContatoBack4App contatoBack4App;

  const ContatosPage({super.key, required this.contatoBack4App});

  @override
  State<ContatosPage> createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  var contato = ContatoBack4App.vazio();
  XFile? photo;
  var nomeController = TextEditingController(text: "");
  var telefoneController = TextEditingController(text: "");
  var contatosBack4AppRepository = ContatosBack4AppRepository();

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      photo = XFile(croppedFile.path);

      String path =
          (await path_provider.getApplicationDocumentsDirectory()).path;
      String name = basename(photo!.name);
      contato.foto = "$path/$name";
      await photo!.saveTo("$path/$name");

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contato.objectId = widget.contatoBack4App.objectId;
    contato.createdAt = widget.contatoBack4App.createdAt;
    contato.updatedAt = widget.contatoBack4App.updatedAt;
    contato.nome = widget.contatoBack4App.nome;
    contato.telefone = widget.contatoBack4App.telefone;
    contato.foto = widget.contatoBack4App.foto;

    nomeController.text = contato.nome;
    telefoneController.text = contato.telefone;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Contato")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListView(children: [
          GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              photo = await picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                cropImage(photo!);
              }
            },
            child: contato.foto == ""
                ? Image.asset(
                    width: 200,
                    height: 200,
                    AppImages.profile1,
                  )
                : Image.file(width: 200, height: 200, File(contato.foto)),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nome"),
                  TextField(
                    controller: nomeController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Telefone"),
                  TextField(
                    controller: telefoneController,
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                contato.nome = nomeController.text;
                contato.telefone = telefoneController.text;
                //contato.foto = nomeController.text;
                if (contato.objectId == "") {
                  await contatosBack4AppRepository.criar(contato);
                } else {
                  await contatosBack4AppRepository.atualizar(contato);
                }

                Navigator.pop(context);
              },
              child: const Icon(Icons.save),
            ),
          )
        ]),
      ),
    ));
  }
}
