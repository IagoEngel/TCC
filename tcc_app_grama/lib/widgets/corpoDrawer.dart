import 'package:flutter/material.dart';
import 'package:tcc_app_grama/telas/camera_screen.dart';
import 'package:tcc_app_grama/telas/historico_screen.dart';
import 'package:tcc_app_grama/telas/instrucoes.dart';
import 'package:tcc_app_grama/telas/menu.dart';

Widget corpoDrawer(BuildContext context, String tituloAppBar) {
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
          if (titulo == tituloAppBar) {
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
          _flatButton("Histórico de análise", HistoricoScreen()),
        ],
      ),
    );
  }