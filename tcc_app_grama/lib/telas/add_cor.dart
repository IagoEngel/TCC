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

  TextEditingController _controllerNutriente = new TextEditingController();
  TextEditingController _controllerNotacao = new TextEditingController();
  TextEditingController _controllerHexa = new TextEditingController();
  TextEditingController _controllerNomeCor = new TextEditingController();

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
          title: Text('Cadastrando cor'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controllerHexa,
                decoration: InputDecoration(labelText: 'Hexa'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controllerNotacao,
                  decoration: InputDecoration(labelText: 'Notação da tabela Munsell'),
             
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controllerNutriente,
                  decoration: InputDecoration(labelText: 'Nutriente'),
              
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controllerNomeCor,
                  decoration: InputDecoration(labelText: 'Nome da Cor'),
              
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text('Cadastrar'),
                  onPressed: () {
                    final String hexa = _controllerHexa.text;
                    final String notacao = _controllerNotacao.text;
                    final String nutriente = _controllerNutriente.text;
                    final String nomeCor = _controllerNomeCor.text;
     
                     _repository.cadastraMunsell(nutriente,notacao,hexa,nomeCor);
                
                    
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




