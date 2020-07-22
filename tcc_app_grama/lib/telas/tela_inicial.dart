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
        backgroundColor: Color.fromRGBO(45, 106, 79, 1.0),
        title: Text("Gramado App - TCC"),
      ),
      drawer: _drawer(),
      backgroundColor: Color.fromRGBO(250, 250, 255, 1.0),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bem vindo ao nosso App!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Como é sua primeira vez utilizando este aplicativo. Aqui vão algumas instruções de como tirar as fotos do seu gramado:\n",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "1) Você terá que tirar 3 fotos para análise. Então, procure tirar as fotos de ângulos e posições diferentes. \n" +
                    "2) É recomendável que a camêra esteja na horizontal. E que as fotos peguem grande parte do gramado. \n" +
                    "3) Fique atento à qualquer outra coisa, que possua a cor verde, além do gramado na imagem tirada. Ex: árvores, outras plantas, maquinário, etc.\n",
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(height: 5),
            FlatButton(
              padding: EdgeInsets.only(left: 40, right: 40, top:7, bottom:7),
              color: Color.fromRGBO(27, 67, 50, 1.0),
              child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Camera()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _drawer() {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          child: _contaUsuario(),
          decoration: BoxDecoration(color: Color.fromRGBO(233, 236, 239, 1.0)),
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
