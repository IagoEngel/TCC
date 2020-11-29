import 'package:flutter/material.dart';
import 'package:tcc_app_grama/telas/camera_screen.dart';
import 'package:tcc_app_grama/telas/instrucoes.dart';
import 'package:tcc_app_grama/widgets/drawerheader.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
        title: Text(
          "Início",
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
      body: _corpoTela(),
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
          if (pagina == null || titulo == "Início") {
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
          _flatButton("Análise do gramado", Camera()),
          _divider(),
          _flatButton("Histórico de análise", null),
        ],
      ),
    );
  }

  Widget _corpoTela() {
    Widget _caixaTexto() {
      return Container(
        width: MediaQuery.of(context).size.width*0.88,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.80),
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "AppGRAMADO",
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            SizedBox(height: 15),
            Text(
              "Olá, bem-vindo(a) ao nosso App!\nAqui você encontrará uma maneira melhor de classificar a coloração de seu gramado. Para iniciar, acesse o menu e explore 'Informações' antes de inicar a análise do seu gramado.",
              style: TextStyle(color: Colors.black, fontSize: 19),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/grama.jpeg"), fit: BoxFit.cover),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _caixaTexto(),
          ],
        ),
      ),
    );
  }
}
