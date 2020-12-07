import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app_grama/model/munsell_model.dart';
import 'package:tcc_app_grama/repository/munsell_repositores.dart';
import 'package:tcc_app_grama/widgets/corpoDrawer.dart';
import 'package:tcc_app_grama/widgets/drawerheader.dart';

class Camera extends StatefulWidget {
  String auxSintomas = "NENHUM";

  Map<String, String> sintomas = {
    "NITROGÊNIO":
        "A falta de nitrogênio nas plantas, inicialmente apresentam os sintomas em folhas mais velhas, reduz o crescimento e os colmos ficam mais finos. As folhas apresentam uma coloração verde-clara, expandindo por toda a folha pelo meio e, posteriormente, pelas laterais. As folhas podem apresentar coloração totalmente amareladas em casos severos.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "FÓSFORO":
        "Com a falta de fósforo nas folhas surge manchas a princípio nas mais velhas. Essas manchas são irregulares tendo início pelas bordas e vão se espalhando indo em direção a bainha, nervura central e ponta das folhas. Essas manchas apresentam coloração marrom com aparência enrugada e fina, coloração marrom-escura com estrias e pontuações marrom-avermelhadas.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "POTÁSSIO":
        " Tendo início nas folhas mais velhas, com a falta de potássio surgem manchas escuras avermelhadas, além das manchas, as folhas apresentam necrose de formato retilíneo ao longo das nervuras secundárias e das bordas, apresentam também secamento da ponta. Além disso, a borda das folhas se enrola e paralisa o crescimento, dando à planta a aparência de um leque.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "CÁLCIO":
        "A deficiência pela falta do cálcio se inicia nas folhas mais novas, apresentando uma coloração marrom-clara nas bordas. Apresentam também deformação lateral, laceração com estrias esbranquiçadas, enrolamento e necrose do ápice do limbo.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "MAGNÉSIO":
        "Os sintomas pela falta do magnésio são apresentados em folhas mais velhas, com manchas de coloração avermelhadas e/ou alaranjadas, clorose amarelo-alaranjada e manchas necróticas irregulares marrom-avermelhadas. Além de que o crescimento da planta é reduzido.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "ENXOFRE":
        "Os sintomas da falta de enxofre nas folhas, são apresentadas inicialmente nas folhas mais novas. Apresentam uma coloração amarelada por toda a folha, com maior evidência entre as nervuras.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "BORO":
        "A deficiência de boro é inicialmente apresentada em folhas mais jovens. Apresentam descoloração das folhas e manchas marrom-avermelhada. Além das manchas, surgem estrias brancas e finas, paralelas à nervura central, que se alonga e alarga com o decorrer do tempo. Há também a paralisação do crescimento, dando uma aparência de leque.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "COBRE":
        "O sintoma nas folhas pela falta do nutriente cobre, são apresentadas nas folhas intermediárias e nas mais novas. As folhas apresentam estrias com coloração vermelha, descoloração que tende a ficar transparente. Apresentam também manchas amarronzadas com bordas mais escuras.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "FERRO":
        "As folhas que indicam a falta de ferro, apresentam coloração amarelada e as nervuras verdes, iniciando em folhas mais novas. Com a piora do sintoma as folhas tornam-se inteiramente amareladas. E em casos mais graves, ocorre o branqueamento total das folhas.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "MANGANÊS":
        "As folhas que indicam falta de manganês, também apresentam uma coloração amarelada com as nervuras verdes. Também é iniciado em folhas mais novas.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "ZINCO":
        "As folhas com falta de zinco, apresentam coloração amarelada, posteriormente esbranquiçada e manchas vermelhas. A evolução se dá com o início nas bordas de folhas mais novas, onde surge faixas com a coloração amarelada e as manchas em tons avermelhados e as pontas ficam necrosadas. Em folhas mais velhas, as laterais ficam avermelhadas. Há também casos onde ocorre os três tipos de coloração, porém apenas em casos mais graves.\n\nFonte: Guia de Diagnose Visual de Deficiências Nutricionais em Sorgo-Sacarino",
    "": "",
  };

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
  //variável para verificar se houve erro na busca da cor pelo banco ou para quando abrir a tela
  bool iniciouTela = true;
  bool naoAchouCor = true;
  bool habilitarBotao = false;
  bool fotoDaGaleria;

  Future getImage() async {
    File imagem;

    imagem = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      fotoDaGaleria = false;
      _fotoGramado = imagem;
    });
  }

  Future getImageGaleria() async {
    File imagem;

    imagem = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      fotoDaGaleria = true;
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
              corpoDrawer(context, "Análise do gramado"),
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
                    (iniciouTela)
                        ? Container()
                        : _botaoSintoma(widget.sintomas[widget.auxSintomas]),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botaoSintoma(String sintoma) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
      child: RaisedButton(
        color: Color.fromRGBO(138, 0, 16, 1.0),
        disabledColor: Color.fromRGBO(138, 0, 16, 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        textColor: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info, size: 17),
            Expanded(child: SizedBox()),
            Text(
              "Visualizar sintomas",
              style: TextStyle(fontSize: 17),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
        onPressed: () {
          if (sintoma != null) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Text(sintoma),
                );
              },
            );
          } else
            return null;
        },
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
    Widget _atributosCor() {
      return FutureBuilder(
        future: this.munsellFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<MunsellModel>> snapshot) {
          if (!snapshot.hasData) {
            naoAchouCor = true;
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                habilitarBotao = false;
              });
            });
            return Column(
              children: [
                Text(
                  "Hexa: #${corBox.toString().substring(10, 16)}",
                ),
                Text(
                  "Cor não encontrada",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            naoAchouCor = true;
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                habilitarBotao = false;
              });
            });
            return Text(
              "ERRO = ${snapshot.error}",
              style: TextStyle(color: Colors.red),
            );
          } else {
            naoAchouCor = false;
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                widget.auxSintomas =
                    snapshot.data.first.nutriente.toUpperCase();
                if (!iniciouTela) habilitarBotao = true;
              });
            });
            return Column(
              children: [
                (iniciouTela)
                    ? Text("Cor em hexadecimal: #ffffff")
                    : Text("Cor em hexadecimal: ${snapshot.data.first.hexa}"),
                (iniciouTela)
                    ? Text("Deficiência de nutriente:")
                    : Text("Deficiência de nutriente: ${snapshot.data.first.nutriente}"),
                (iniciouTela)
                    ? Text("Munsell - Notação da cor:")
                    : Text("Munsell - Notação da cor: ${snapshot.data.first.notacao}"),
                (iniciouTela)
                    ? Text("Nome da cor: branco")
                    : Text("Nome da cor: ${snapshot.data.first.nomecor}"),
              ],
            );
          }
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: corBox,
            border: Border.all(color: Colors.black),
          ),
          child: null,
        ),
        SizedBox(width: 50),
        _atributosCor(),
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
          height: 400,
          width: 300,
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
      height: 400,
      width: 300,
      child: Align(
        alignment: Alignment.center,
        child: RepaintBoundary(
          child: GestureDetector(
            onPanDown: (details) {
              iniciouTela = false;
              procurarCor(details.globalPosition);
              String hexa = corBox.toString().substring(10, 16);
              munsellFuture = _repository.buscaMunsell(hexa);
            },
            /* onPanUpdate: (details) {
              iniciouTela = false;
              procurarCor(details.globalPosition);
              String hexa = corBox.toString().substring(10, 16);
              munsellFuture = _repository.buscaMunsell(hexa);
            }, */
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
            "Remover foto",
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
          munsellFuture = _repository.findAll();
          _stateController.add(corBox);
        });
      },
    );
  }
}
