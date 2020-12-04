import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app_grama/model/historico.dart';
import 'package:tcc_app_grama/widgets/corpoDrawer.dart';
import 'package:tcc_app_grama/widgets/drawerheader.dart';

class HistoricoScreen extends StatefulWidget {
  var historico = new List<Historico>();

  HistoricoScreen(){
    historico = [];
  }

  @override
  _HistoricoScreenState createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {

  Future load() async{
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if(data != null){
      Iterable decoded = jsonDecode(data);
      List<Historico> resultado = decoded.map((e) => Historico.fromJson(e)).toList();
      setState(() {
        widget.historico = resultado;
      });
    }
  }

  _HistoricoScreenState(){
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
        title: Text(
          "Histórico de análise",
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              drawerHeader(),
              corpoDrawer(context, "Histórico de análise"),
            ],
          ),
        ),
      ),
      body: _corpoTela(),
    );
  }

  Widget _corpoTela(){
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            itemCount: widget.historico.length,
            itemBuilder: (context, index){
              return Card(
                
              );
            },
          ),
        ],
      ),
    );
  }

}
