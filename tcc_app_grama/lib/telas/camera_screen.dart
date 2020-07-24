import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user.dart';

class Camera extends StatefulWidget {
  User user;

  Camera({@required this.user});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _primeiraImagem;
  File _segundaImagem;
  File _terceiraImagem;
  File _quartaImagem;
  var _cor1 = Colors.transparent;
  var _cor2 = Colors.transparent;
  var _cor3 = Colors.transparent;
  var _cor4 = Colors.transparent;
  bool erased = false;

  Future getImage(int i) async {
    File imagem;

    imagem = await ImagePicker.pickImage(source: ImageSource.camera);

    if (i == 1)
      setState(() {
        _primeiraImagem = imagem;
      });
    else if (i == 2)
      setState(() {
        _segundaImagem = imagem;
      });
    else if (i == 3)
      setState(() {
        _terceiraImagem = imagem;
      });
    else
      setState(() {
        _quartaImagem = imagem;
      });
  }

  @override
  void initState() {
    super.initState();
    getImage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(45, 106, 79, 1.0),
        title: Text("Gramado App - TCC"),
      ),
      drawer: _drawer(),
      body: (_primeiraImagem == null && !erased)
          ? Text("Erro ao carregar a imagem")
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Container(
                  margin: EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: Column(
                    children: [
                      _rowImagem(_primeiraImagem, _segundaImagem),
                      SizedBox(height: 20),
                      _rowImagem2(_terceiraImagem, _quartaImagem),
                      Container(
                        padding: EdgeInsets.only(
                            top: 20, left: 70, right: 70, bottom: 10),
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
          "${widget.user.email}",
          style: TextStyle(fontSize: 23),
        ),
      ],
    );
  }

  Widget _rowImagem(File imagem1, File imagem2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (imagem1 == null) ? _addImagem(1) : _grid1(imagem1),
        SizedBox(width: 29),
        (imagem2 == null) ? _addImagem(2) : _grid2(imagem2),
      ],
    );
  }

  Widget _rowImagem2(File imagem3, File imagem4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (imagem3 == null) ? _addImagem(3) : _grid3(imagem3),
        SizedBox(width: 29),
        (imagem4 == null) ? _addImagem(4) : _grid4(imagem4),
      ],
    );
  }

  Widget _addImagem(int i) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          getImage(i);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 3),
          ),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Icon(
              Icons.add_a_photo,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget _grid1(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor1 == Colors.transparent)
              ? _cor1 = Colors.blue
              : _cor1 = Colors.transparent;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _cor1, width: 3),
        ),
        child: Image.file(
          imagem,
          fit: BoxFit.contain,
          height: 220,
        ),
      ),
    );
  }

  Widget _grid2(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor2 == Colors.transparent)
              ? _cor2 = Colors.blue
              : _cor2 = Colors.transparent;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _cor2, width: 3),
        ),
        child: Image.file(
          imagem,
          fit: BoxFit.contain,
          height: 220,
        ),
      ),
    );
  }

  Widget _grid3(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor3 == Colors.transparent)
              ? _cor3 = Colors.blue
              : _cor3 = Colors.transparent;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _cor3, width: 3),
        ),
        child: Image.file(
          imagem,
          fit: BoxFit.contain,
          height: 220,
        ),
      ),
    );
  }

  Widget _grid4(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor4 == Colors.transparent)
              ? _cor4 = Colors.blue
              : _cor4 = Colors.transparent;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _cor4, width: 3),
        ),
        child: Image.file(
          imagem,
          fit: BoxFit.contain,
          height: 220,
        ),
      ),
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
      onPressed: () {
        setState(() {
          _cor1 = Colors.blue;
          _cor2 = Colors.blue;
          _cor3 = Colors.blue;
          _cor4 = Colors.blue;
        });
      },
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
      onPressed: () {
        setState(() {
          if (_cor1 == Colors.blue) {
            _primeiraImagem = null;
            _cor1 = Colors.transparent;
            erased = true;
          }
          if (_cor2 == Colors.blue) {
            _segundaImagem = null;
            _cor2 = Colors.transparent;
          }
          if (_cor3 == Colors.blue) {
            _terceiraImagem = null;
            _cor3 = Colors.transparent;
          }
          if (_cor4 == Colors.blue) {
            _quartaImagem = null;
            _cor4 = Colors.transparent;
          }
        });
      },
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
