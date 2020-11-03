import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class TelaCor extends StatefulWidget {
  var _primeira, _segunda, _terceira;

  TelaCor(this._primeira, this._segunda, this._terceira);

  @override
  _TelaCorState createState() => _TelaCorState();
}

class _TelaCorState extends State<TelaCor> {
  var cor1, cor2, cor3;
  var corMedia;

  Future<List<PaletteGenerator>> _getCorDominante() async {
    List<PaletteGenerator> cores = new List<PaletteGenerator>();
    cores.add(await PaletteGenerator.fromImageProvider(
        Image.file(widget._primeira).image));
    cores.add(await PaletteGenerator.fromImageProvider(
        Image.file(widget._segunda).image));
    cores.add(await PaletteGenerator.fromImageProvider(
        Image.file(widget._terceira).image));
    return cores;
  }

  FutureBuilder<List<PaletteGenerator>> _future() {
    return FutureBuilder(
      future: _getCorDominante(),
      builder: (BuildContext context,
          AsyncSnapshot<List<PaletteGenerator>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return Text("ERROR = ${snapshot.error}");
            else {
              cor1 = snapshot.data[0].dominantColor.color;
              cor2 = snapshot.data[1].dominantColor.color;
              cor3 = snapshot.data[2].dominantColor.color;
              _calcularMedia();
              return Column(
                children: [
                  Text(
                    "Imagens salvas no dispositivo e analisadas",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Container(height: 100, width: 100, color: cor1),
                  Text(
                      "rbg da imagem 1 = ${cor1.red}, ${cor1.green}, ${cor1.blue}"),
                  Container(height: 100, width: 100, color: cor2),
                  Text(
                      "rbg da imagem 2 = ${cor2.red}, ${cor2.green}, ${cor2.blue}"),
                  Container(height: 100, width: 100, color: cor3),
                  Text(
                      "rbg da imagem 3 = ${cor3.red}, ${cor3.green}, ${cor3.blue}"),
                  Text("\nCOR MÉDIA\n"),
                  Container(height: 100, width: 100, color: corMedia),
                ],
              );
            }
        }
      },
    );
  }

  void _calcularMedia() async {
    var r = (cor1.red + cor2.red + cor3.red) / 3;
    var b = (cor1.green + cor2.green + cor3.green) / 3;
    var g = (cor1.blue + cor2.blue + cor3.blue) / 3;
    corMedia = Color.fromRGBO(r.round(), g.round(), b.round(), 1.0);
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Center(child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _future(),
          ),),
        ),
      ),
    );
  }
}
