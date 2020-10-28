import 'package:flutter/material.dart';
import 'package:tcc_app_grama/services/auth.dart';
import 'package:tcc_app_grama/telas/camera_screen.dart';
import 'package:tcc_app_grama/models/user.dart';

class TelaInicial extends StatefulWidget {
  User user;

  TelaInicial({@required this.user});

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  AuthService _auth = AuthService();

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
                      "1) Você terá 4 fotos  para análise. Então, procure tirar as fotos de ângulos e posições diferentes.\n\n2)É recomendável que a camêra esteja na horizontal. E que as fotos peguem grande parte do gramado.\n\n3) Fique atento à qualquer outra coisa, que possua a cor, além do gramado na imagem tirada. Ex: árvores, outras plantas, maquinário, etc."),
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
                    builder: (context) => Camera(user: widget.user),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
