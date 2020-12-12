import 'package:flutter/material.dart';
import 'package:tcc_app_grama/telas/camera_screen.dart';
import 'package:tcc_app_grama/telas/instrucoes.dart';
import 'package:tcc_app_grama/widgets/corpoDrawer.dart';
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
              corpoDrawer(context, "Início"),
            ],
          ),
        ),
      ),
      body: _corpoTela(),
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
              "GramaTec",
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            SizedBox(height: 15),
            Text(
              "Olá, bem-vindo(a) ao nosso App!\nAqui você encontrará uma maneira melhor de classificar a coloração de seu gramado. Para iniciar, acesse o menu e explore 'Informações' antes de iniciar a análise do seu gramado.",
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
