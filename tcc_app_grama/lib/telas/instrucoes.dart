import 'package:flutter/material.dart';
import 'package:tcc_app_grama/telas/camera_screen.dart';
import 'package:tcc_app_grama/telas/menu.dart';
import 'package:tcc_app_grama/widgets/corpoDrawer.dart';
import 'package:tcc_app_grama/widgets/drawerheader.dart';

class Instrucoes extends StatefulWidget {
  @override
  _InstrucoesState createState() => _InstrucoesState();
}

class _InstrucoesState extends State<Instrucoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
        title: Text(
          "Instruções",
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              drawerHeader(),
              corpoDrawer(context, "Instruções"),
            ],
          ),
        ),
      ),
      body: _corpoTela(),
    );
  }

  Widget _corpoTela() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/grama.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textoInstrucao(),
          ],
        ),
      ),
    );
  }

  Widget _textoInstrucao() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(40),
      ),
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Você terá 1 foto para análise por vez. Então, procure tirar ou selecionar fotos que tenham boa incidência de sol, onde há pouca sombra." +
                "\n\nApós selecionar a foto, aperte e/ou deslize sobre a área da foto no app. E, solte para adquirir a cor representante daquele pixel da imagem." +
                "\n\nSomente usuários administradores podem cadastrar os valores hexadecimais das cores, seu intervalo na tabela Munsell e as deficiências que representam.",
            style: TextStyle(fontSize: 19),
          ),
        ],
      ),
    );
  }
}
