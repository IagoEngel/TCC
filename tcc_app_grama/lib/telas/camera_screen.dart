import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _primeiraImagem;

  Future getImage(File img) async {
    File imagem;

    imagem = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      img = imagem;
    });
  }

  @override
  void initState() {
    super.initState();
    getImage(_primeiraImagem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(45, 106, 79, 1.0),
        title: Text("Gramado App - TCC"),
      ),
      drawer: _drawer(),
      body: _primeiraImagem == null
          ? Text("Erro ao carregar a imagem")
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Container(
                  margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Column(
                    children: [
                      _rowImagem(_primeiraImagem),
                      SizedBox(height: 25),
                      _rowImagem(_primeiraImagem),
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, left: 70, right: 70, bottom: 10),
                        child: Column(
                          children: [
                            _rowSeleciona(),
                            _rowExcluir(),
                            _rowAnalisar(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: _contaUsuario(),
            decoration:
                BoxDecoration(color: Color.fromRGBO(233, 236, 239, 1.0)),
          ),
          ListTile(
            leading: Icon(Icons.show_chart, color: Colors.black),
            title: Text(
              "Estatísticas",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.black),
            title: Text(
              "Informações",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.black),
            title: Text(
              'Desconectar',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _contaUsuario() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Color.fromRGBO(27, 67, 50, 1.0),
          radius: 42,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Color.fromRGBO(33, 37, 41, 1.0),
            radius: 38,
            child: Icon(Icons.person, size: 60),
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        Text(
          "emailUsuario@email.br",
          style: TextStyle(fontSize: 23),
        ),
      ],
    );
  }

  Widget _rowImagem(imagem){
    return Row(
      children: [
        _grid(imagem),
        Expanded(child: SizedBox()),
        _grid(imagem),
      ],
    );
  }

  Widget _grid(File imagem) {
    return Image.file(
      imagem,
      fit: BoxFit.contain,
      height: 220,
    );
  }

  Widget _rowSeleciona() {
    return RaisedButton(
      color: Color.fromRGBO(0, 123, 255, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      textColor: Colors.white,
      child: Row(
        children: [
          Icon(Icons.check, size: 20),
          SizedBox(width: 12),
          Text(
            "Selecionar todos",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget _rowExcluir() {
    return RaisedButton(
      color: Color.fromRGBO(187, 0, 0, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      textColor: Colors.white,
      child: Row(
        children: [
          Icon(Icons.clear, size: 20),
          SizedBox(width: 18),
          Text(
            "Excluir seleção",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget _rowAnalisar() {
    return RaisedButton(
      color: Color.fromRGBO(0, 100, 7, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      textColor: Colors.white,
      child: Row(
        children: [
          Icon(Icons.send, size: 18),
          SizedBox(width: 24),
          Text(
            "Analisar fotos",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      onPressed: () {
        GallerySaver.saveImage(_primeiraImagem.path);
      },
    );
  }
}
