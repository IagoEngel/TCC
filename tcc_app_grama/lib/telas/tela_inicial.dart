import 'package:flutter/material.dart';
import 'package:tcc_app_grama/telas/camera_screen.dart';

class TelaInicial extends StatefulWidget {

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {

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
      backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textOla(),
            _instrucoes(),
            Divider(
              color: Colors.black,
              indent: 35,
              endIndent: 35,
              thickness: 2,
              height: 80,
            ),
            _comecarFotos(),
          ],
        ),
      ),
    );
  }

  Widget _textOla() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(150, 128, 131, 1.0),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        "Olá, bem-vindo(a) ao nosso App!",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _instrucoes() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 10, right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(150, 128, 131, 1.0),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Text(
            "Se esta é sua primeira vez com o aplicativo, clique no botão para saber mais sobre as instruções.",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          FlatButton(
            padding: EdgeInsets.only(right: 25, left: 25),
            color: Color.fromRGBO(138, 0, 16, 1.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Instruções",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            onPressed: () {
              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                      "1) Você terá 4 fotos para análise. Então, procure tirar as fotos de ângulos e posições diferentes.\n\n2)É recomendável que a camêra esteja na horizontal. E que as fotos peguem grande parte do gramado.\n\n3) Fique atento à qualquer outra coisa, que possua a cor, além do gramado na imagem tirada. Ex: árvores, outras plantas, maquinário, etc."),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _comecarFotos() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(150, 128, 131, 1.0),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Text(
            "Comece a analisar o seu gramado!",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 20),
          FlatButton(
            color: Color.fromRGBO(138, 0, 16, 1.0),
            padding: EdgeInsets.only(left: 55, right: 55, top: 7, bottom: 7),
            child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Camera(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
