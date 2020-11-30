import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc_app_grama/model/munsell_model.dart';
import 'package:tcc_app_grama/repository/munsell_repositores.dart';
import 'package:tcc_app_grama/telas/instrucoes.dart';
import 'package:tcc_app_grama/telas/menu.dart';
import 'package:tcc_app_grama/widgets/drawerheader.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _fotoGramado;
  final StreamController<Color> _stateController = StreamController<Color>();
  GlobalKey imageKey = GlobalKey();
  GlobalKey currentKey;
  Color corBox = Colors.white;
  Color corSelecionada;
  img.Image fotoAux;
  Future<List<MunsellModel>> munsellFuture;
  MunsellRepository _repository;

  Future getImage() async {
    File imagem;

    imagem = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _fotoGramado = imagem;
    });
  }

  Future getImageGaleria() async {
    File imagem;

    imagem = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _fotoGramado = imagem;
    });
  }

  @override
  void initState() {
    currentKey = imageKey;
    _repository = MunsellRepository();
    munsellFuture = _repository.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
        title: Text(
          "Análise do gramado",
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              drawerHeader(),
              _corpoDrawer(),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: [
              //IMAGENS
              Container(
                padding: EdgeInsets.only(top: 34, left: 20, right: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    _rowImagem(),
                    SizedBox(height: 10),
                    _rowCor(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              // BOTÕES
              Container(
                width: MediaQuery.of(context).size.width * 0.73,
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    _rowExcluir(),
                    SizedBox(height: 8),
                    _rowAnalisar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _corpoDrawer() {
    Widget _divider() {
      return Divider(
        color: Colors.black54,
        height: 10,
      );
    }

    Widget _flatButton(String titulo, Widget pagina) {
      return FlatButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("$titulo", style: TextStyle(fontSize: 20)),
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (pagina == null || titulo == "Análise do gramado") {
            return null;
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => pagina),
            );
          }
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _flatButton("Início", Menu()),
          _divider(),
          _flatButton("Instruções", Instrucoes()),
          _divider(),
          _flatButton("Análise do gramado", null),
          _divider(),
          _flatButton("Histórico de análise", null),
        ],
      ),
    );
  }

  Widget _rowImagem() {
    return StreamBuilder(
      initialData: Colors.white,
      stream: _stateController.stream,
      builder: (buildContext, snapshot) {
        corSelecionada = snapshot.data ?? Colors.white;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (_fotoGramado == null) ? _addImagem() : _grid1(),
          ],
        );
      },
    );
  }

  Widget _rowCor() {
    Widget _textosCor() {
      return Column(
        children: [
          Text("${corBox.toString()}"),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: corBox,
            border: Border.all(color: Colors.black),
          ),
          child: null,
        ),
        SizedBox(width: 50),
        _textosCor(),
      ],
    );
  }

  Widget _addImagem() {
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
                      getImage();
                    },
                  ),
                  Divider(thickness: 2.5),
                  ListTile(
                    leading: Icon(Icons.perm_media),
                    title: Text("Galeria"),
                    onTap: () {
                      getImageGaleria();
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
          border: Border.all(color: Colors.transparent, width: 5),
        ),
        child: Container(
          height: 420,
          width: 315,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 5),
          ),
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black,
            size: 80,
          ),
        ),
      ),
    );
  }

  Widget _grid1() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(250, 37, 62, 1.0), width: 5),
      ),
      height: 420,
      width: 315,
      child: Align(
        alignment: Alignment.center,
        child: RepaintBoundary(
          child: GestureDetector(
            onPanDown: (details) {
              procurarCor(details.globalPosition);
              String hexa = corBox.toString();
              //print(hexa.substring(10, 16));
            },
            onPanUpdate: (details) {
              procurarCor(details.globalPosition);
              String hexa = corBox.toString();
              //print(hexa.substring(10, 16));
            },
            onPanEnd: (details) {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FutureBuilder(
                    future: munsellFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MunsellModel>> snapshot) {
                      print("SNAPSHOT: ${snapshot.hasData}");
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Text('Error: ${snapshot.error}'),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var item = snapshot.data[index];

                            return Container(
                              width: 200,
                              height: 200,

                              child: Row(
                                children: [
                                  Text(item.nomecor),
                                  Text(item.descricao),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              );
            },
            child: Image.file(
              _fotoGramado,
              key: imageKey,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  void procurarCor(Offset globalPosition) async {
    if (fotoAux == null) {
      await loadImageBundleBytes();
    }
    _calcularPixel(globalPosition);
  }

  void _calcularPixel(Offset globalPosition) {
    RenderBox box = currentKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    double widgetScale = box.size.width / fotoAux.width;
    px = (px / widgetScale);
    py = (py / widgetScale);

    int pixel32 = fotoAux.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    _stateController.add(Color(hex));

    setState(() {
      currentKey = imageKey;
      corBox = Color(hex);
    });
  }

  Future<void> loadImageBundleBytes() async {
    final imageBytes = await _fotoGramado.readAsBytes();
    setImageBytes(imageBytes);
  }

  void setImageBytes(final imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    fotoAux = null;
    fotoAux = img.decodeImage(values);
  }

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
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
            "Descartar",
            style: TextStyle(fontSize: 18),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      onPressed: () {
        setState(() {
          _fotoGramado = null;
          fotoAux = null;
          corBox = Colors.white;
          _stateController.add(corBox);
        });
      },
    );
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
            "Salvar",
            style: TextStyle(fontSize: 18),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
      onPressed: () async {
        if (_fotoGramado != null) {
          //await GallerySaver.saveImage(_fotoGramado.path);
          String hexa = corBox.toString();
          print(hexa.substring(10, 16));
          var teste = _repository.buscaMunsell(hexa);
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 70,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Foto salva no dispositivo !",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
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
                    Text(
                      "É necessário selecionar a foto para salvar no dispositivo.",
                      textAlign: TextAlign.center,
                    ),
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
}
