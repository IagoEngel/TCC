import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tcc_app_grama/services/auth.dart';
import '../models/user.dart';

class Camera extends StatefulWidget {
  User user;

  Camera({@required this.user});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  AuthService _auth = AuthService();
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

  Future getImageGaleria(int i) async {
    File imagem;

    imagem = await ImagePicker.pickImage(source: ImageSource.gallery);

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
        backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
        title: Text(
          "Gramado App - TCC",
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: _drawer(),
      backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
      body: (_primeiraImagem == null && !erased)
          ? Text("Erro ao carregar a imagem")
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Container(
                  padding: EdgeInsets.only(top: 34, left: 20, right: 20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      _rowImagem(_primeiraImagem, _segundaImagem),
                      SizedBox(height: 10),
                      _rowImagem2(_terceiraImagem, _quartaImagem),
                      Container(
                        padding: EdgeInsets.only(
                            top: 50, left: 70, right: 70, bottom: 10),
                        child: Column(
                          children: [
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
            onTap: () async {
              await _auth.signOff();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
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
        Expanded(child: SizedBox()),
        (imagem2 == null) ? _addImagem(2) : _grid2(imagem2),
      ],
    );
  }

  Widget _rowImagem2(File imagem3, File imagem4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (imagem3 == null) ? _addImagem(3) : _grid3(imagem3),
        Expanded(child: SizedBox()),
        (imagem4 == null) ? _addImagem(4) : _grid4(imagem4),
      ],
    );
  }

  Widget _addImagem(int i) {
    return GestureDetector(
      onTap: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Câmera"),
                    onTap: () {
                      getImage(i);
                    },
                  ),
                  Divider(thickness: 2.5),
                  ListTile(
                    leading: Icon(Icons.perm_media),
                    title: Text("Galeria"),
                    onTap: () {
                      getImageGaleria(i);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 3),
        ),
        child: Container(
          height: 220,
          width: 165,
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
    );
  }

  Widget _grid1(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor1 == Colors.transparent)
              ? _cor1 = Color.fromRGBO(250, 37, 62, 1.0)
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
          width: 165,
        ),
      ),
    );
  }

  Widget _grid2(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor2 == Colors.transparent)
              ? _cor2 = Color.fromRGBO(250, 37, 62, 1.0)
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
          width: 165,
        ),
      ),
    );
  }

  Widget _grid3(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor3 == Colors.transparent)
              ? _cor3 = Color.fromRGBO(250, 37, 62, 1.0)
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
          width: 165,
        ),
      ),
    );
  }

  Widget _grid4(File imagem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          (_cor4 == Colors.transparent)
              ? _cor4 = Color.fromRGBO(250, 37, 62, 1.0)
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
          width: 165,
        ),
      ),
    );
  }

  Widget _rowExcluir() {
    return RaisedButton(
      color: Color.fromRGBO(250, 37, 62, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      textColor: Colors.white,
      child: Row(
        children: [
          Icon(Icons.clear, size: 20),
          Expanded(child: SizedBox()),
          Text(
            "Excluir seleção",
            style: TextStyle(fontSize: 18),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      onPressed: () {
        setState(() {
          if (_cor1 == Color.fromRGBO(250, 37, 62, 1.0)) {
            _primeiraImagem = null;
            _cor1 = Colors.transparent;
            erased = true;
          }
          if (_cor2 == Color.fromRGBO(250, 37, 62, 1.0)) {
            _segundaImagem = null;
            _cor2 = Colors.transparent;
          }
          if (_cor3 == Color.fromRGBO(250, 37, 62, 1.0)) {
            _terceiraImagem = null;
            _cor3 = Colors.transparent;
          }
          if (_cor4 == Color.fromRGBO(250, 37, 62, 1.0)) {
            _quartaImagem = null;
            _cor4 = Colors.transparent;
          }
        });
      },
    );
  }

  Future<PaletteGenerator> _getCorDominante(int i) async {
    var cores;
    if (i == 1)
      cores = await PaletteGenerator.fromImageProvider(
          Image.file(_primeiraImagem).image);
    if (i == 2)
      cores = await PaletteGenerator.fromImageProvider(
          Image.file(_segundaImagem).image);
    if (i == 3)
      cores = await PaletteGenerator.fromImageProvider(
          Image.file(_terceiraImagem).image);
    if (i == 4)
      cores = await PaletteGenerator.fromImageProvider(
          Image.file(_quartaImagem).image);
    return cores;
  }

  Widget _rowAnalisar() {
    return RaisedButton(
      color: Color.fromRGBO(138, 0, 16, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      textColor: Colors.white,
      child: Row(
        children: [
          Icon(Icons.send, size: 18),
          Expanded(child: SizedBox()),
          Text(
            "Analisar fotos",
            style: TextStyle(fontSize: 18),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      onPressed: () async {
        if (_primeiraImagem !=
                null /*  &&
            _segundaImagem != null &&
            _terceiraImagem != null &&
            _quartaImagem != null */
            ) {
          /* await GallerySaver.saveImage(_primeiraImagem.path);
          await GallerySaver.saveImage(_segundaImagem.path);
          await GallerySaver.saveImage(_terceiraImagem.path);
          await GallerySaver.saveImage(_quartaImagem.path); */
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Column(
                  children: [
                    _dialogAnalisandoFotos(1),
                    _dialogAnalisandoFotos(2),
                    _dialogAnalisandoFotos(3),
                    _dialogAnalisandoFotos(4),
                  ],
                ),
              );
            },
          );
        } else {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Column(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 70,
                    ),
                    SizedBox(height: 10),
                    Text("É necessário quatro \nfotos para continuar"),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _dialogAnalisandoFotos(int i) {
    return FutureBuilder<PaletteGenerator>(
      future: _getCorDominante(i),
      builder:
          (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return Text('Ops ocorreu um erro: ${snapshot.error}');
            else {
              return Column(
                children: [
                  Text("Cor da imagem $i:"),
                  Container(height: 50,width: 50, color: snapshot.data.dominantColor.color),
                ],
              );
            }
        }
      },
    );
  }
}
