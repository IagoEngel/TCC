import 'package:tcc_app_grama/model/munsell_model.dart';
import 'package:tcc_app_grama/repository/munsell_repositores.dart';
import 'package:flutter/material.dart';

class AddCor extends StatefulWidget {
  AddCor({Key key}) : super(key: key);

  @override
  _AddCorState createState() => _AddCorState();
}

class _AddCorState extends State<AddCor> {
  Future<MunsellModel> munsellFuture;
  MunsellRepository _repository;


   final TextEditingController _controladorHexa = TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();
  final TextEditingController _controladorMineral = TextEditingController();
  final TextEditingController _controladorFormula = TextEditingController();
  final TextEditingController  _controladorMunsell = TextEditingController();
  final TextEditingController _controladorNomeCor = TextEditingController();



  @override
  void initState() {
    super.initState();
    
    _repository = MunsellRepository();
   
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastrando produto'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controladorHexa,
                decoration: InputDecoration(labelText: 'Hexa'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorDescricao,
                  decoration: InputDecoration(labelText: 'Descricao'),
             
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorMineral,
                  decoration: InputDecoration(labelText: 'Mineral'),
              
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorFormula,
                  decoration: InputDecoration(labelText: 'Formula'),
              
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorMunsell,
                  decoration: InputDecoration(labelText: 'Munsell'),
              
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorNomeCor,
                  decoration: InputDecoration(labelText: 'Nome cor'),
              
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text('Cadastrar'),
                  onPressed: () {
                    final String hexa = _controladorHexa.text;
                    final String descricao = _controladorDescricao.text;
                    final String mineral = _controladorMineral.text;
                    final String formula = _controladorFormula.text;
                     final String munsell = _controladorMunsell.text;
                    final String nomecor = _controladorNomeCor.text;
     
                     _repository.cadastraMunsell(hexa, descricao, mineral, formula, munsell, nomecor);
                
                    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




