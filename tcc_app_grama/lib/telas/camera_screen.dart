import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app_grama/model/historico.dart';
import 'package:tcc_app_grama/model/munsell_model.dart';
import 'package:tcc_app_grama/repository/munsell_repositores.dart';
import 'package:tcc_app_grama/widgets/corpoDrawer.dart';
import 'package:tcc_app_grama/widgets/drawerheader.dart';

class Camera extends StatefulWidget {
  String auxSintomas = "NENHUM";
  var historico = new List<Historico>();

  Map<String, String> sintomas = {
    "NITROGÊNIO":
        "Inicialmente, folhas mais velhas apresentam uma coloração verde-clara, que progride para uma clorose total, a qual se inicia a partir da ponta do limbo, expandindo-se em direção à bainha pelo meio da folha e, posteriormente, para as laterais. Em casos severos, as folhas tornam-se totalmente amarelas e ressequidas a partir da ponta. As plantas têm crescimento reduzido e apresentam colmos mais finos.",
    "FÓSFORO":
        "Manchas irregulares, começando de modo disperso pelas bordas, na porção mediana de folhas, a princípio nas mais velhas. As manchas coalescem, estendendo-se ao longo do limbo, em três direções, para a bainha, nervura central e ponta da folha. As manchas têm coloração marrom, opaca, bem suave, com aparência enrugada e fina, muitas vezes demarcadas por uma coloração vermelha-escura, além de estrias e pontuações marrom-escura, além de estrias e pontuações marrom-avermelhadas suaves. Apresenta necrose retilínea ao longo da borda foliar, a partir das folhas mais velhas. ",
    "POTÁSSIO":
        "Inicialmente, nas folhas mais velhas, há ocorrência de manchas escuras avermelhadas e necrose de formato retilíneo ao longo das nervuras secundárias e das bordas, começando das extremidades para a nervura principal, além de secamento da ponta da folha. Ocorre, também, enrolamento parcial da borda para o centro no terço superior da folha e paralisação do crescimento dos internódios, dando à planta a aparência de um leque, com a bainhas das folhas sobrepostas.   ",
    "CÁLCIO":
        "Iniciando pelas mais novas, ocorre deformação lateral da folha, em um ou em ambos os lados, apresentando laceração com estrias esbranquiçadas, enrolamento e necrose do ápice do limbo. Com a progressão dos sintomas, as folhas apresentam necrose marrom-clara nas bordas.",
    "MAGNÉSIO":
        "O sintoma, em folhas mais velhas, caracteriza-se por manchas avermelhadas e/ou alaranjadas, bem como clorose amarelo-alaranjada,  tanto apical como lateral, expandindo-se  para o centro da folha, formando manchas necróticas irregulares marrom-avermelhadas. O ângulo entre folha e colmo é maior e o crescimento da planta é reduzido. ",
    "ENXOFRE":
        "Apresenta plantas com clorose em todo o limbo foliar, inicialmente nas mais novas, com maior evidência entre as nervuras, além de colmos mais claros. ",
    "BORO":
        "Os sintomas iniciam-se em folhas mais jovens, com estrias brancas (perda de pigmentação) e finas, paralelas à nervura central, que se alongam e alargam no decorrer do tempo. A descoloração que  ocorre entre as nervuras ficam translúcidas em alguns pontos. Posteriormente, manchas avermelhadas aparecem ao longo das nervuras, de modo desuniforme, começando pelas folhas mais velhas. Os colmos também apresentam sintomas semelhantes. Ocorre superbrotação de folhas e perfilhamento precoce, também com sintomas. Há paralização do crescimento apical e do alongamento dos internódios, dando à planta uma aparência de leque, semelhante ao que ocorre na deficiência de potássio.",
    "COBRE":
        "Apresenta folhas intermediárias e mais novas com clorose internerval irregular, com aparecimento posterior de nervuras, central e secundárias, avermelhadas (estrias), tanto nas folhas como no colmo e também, pequenas manchas vermelhas. Ocorre descoloração internerval a partir das bordas foliares, que tende a ficar transparente a partir das bordas foliares, que tende a ficar transparente em folhas mais novas. Essa despigmentação é linear e irregular, iniciando-se pelas bordas ou pelo meio do limbo foliar. Posteriormente, essas manchas tornam-se amarronzadas ou necróticas, com bordas mais escuras e bem delimitadas. O limbo das folhas tende a se curvar para baixo, ou seja, em direção à face dorsal. Há um ângulo maior de inserção na folha com o colmo, como ocorre com a deficiência de magnésio.",
    "FERRO":
        "O sintoma de deficiência inicia-se com clorose internerval em folhas mais novas, incialmente mantendo-se verde as nervuras, num padrão de reticulado fino. Com o agravamento dos sintomas, as folhas tornam-se uniformemente amarelas, tendendo ao branqueamento em casos muito severos. ",
    "MANGANÊS":
        "O sintoma de carência em manganês é típico em sorgo-sacarino, iniciando-se nas folhas novas por meio de clorose entre as nervuras, formando um reticulado verde grosso, ou seja, a região que permanece verde ao redor das nervuras é mais larga do que em relação ao sintoma inicial de deficiência de ferro.",
    "ZINCO":
        "Inicialmente, ocorre clorose que coalesce a partir das bordas das folhas mais novas, com o aparecimento da faixa clorótica em um ou em ambos os lados da folha. Ocorre também o avermelhamento das nervuras central e laterais das folhas e estrias vermelhas no colmo. Em folhas mais velhas, baixeiro e medianas, pode ocorrer necrose avermelhada ao longo das laterais do limbo. Também aparecem manchas avermelhadas entremeadas com manchas marrons. As pontas foliares tornam-se necrosadas. Com a agravamento do sintoma, todo o limbo foliar fica necrosado, porém com manchas mais claras nas tonalidades marrom, vermelha e amarela, iniciando-se na ponta da folha e expandindo-se para as laterais.",
  };

  Camera() {
    historico = [];
  }

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
  Offset offsetAuxiliar;
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

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Historico> resultado =
          decoded.map((e) => Historico.fromJson(e)).toList();
      setState(() {
        widget.historico = resultado;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.historico));
  }

  _CameraState() {
    load();
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
                    _botaoSintoma(widget.sintomas[widget.auxSintomas]),
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
          }else
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
              habilitarBotao = false;
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
                habilitarBotao = true;
                if (!iniciouTela)
                  widget.historico.add(Historico(analise: snapshot.data.first));
              });
            });
            return Column(
              children: [
                (iniciouTela)
                    ? Text("Hexa: #ffffff")
                    : Text("Hexa: ${snapshot.data.first.hexa}"),
                (iniciouTela)
                    ? Text("Nutriente:")
                    : Text("Nutriente: ${snapshot.data.first.nutriente}"),
                (iniciouTela)
                    ? Text("Notação:")
                    : Text("Notação: ${snapshot.data.first.notacao}"),
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
              iniciouTela = false;
              procurarCor(details.globalPosition);
              offsetAuxiliar = details.globalPosition;
              String hexa = corBox.toString().substring(10, 16);
              munsellFuture = _repository.buscaMunsell(hexa);
            },
            onPanUpdate: (details) {
              iniciouTela = false;
              procurarCor(details.globalPosition);
              String hexa = corBox.toString().substring(10, 16);
              munsellFuture = _repository.buscaMunsell(hexa);
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
          munsellFuture = _repository.findAll();
          _stateController.add(corBox);
        });
      },
    );
  }

  Widget _rowAnalisar() {
    Widget _txtDeConfirmacao() {
      String txt = "Dados da análise foram salvas no dispositivos !";
      if (!fotoDaGaleria)
        txt = "A foto e sua análise foram salvas no dispositvo !";

      return Text(
        txt,
        textAlign: TextAlign.center,
      );
    }

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
          if (!fotoDaGaleria) await GallerySaver.saveImage(_fotoGramado.path);
          save();
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
                    _txtDeConfirmacao(),
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
                      "É necessário selecionar para salvar o histórico no dispositivo.",
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
