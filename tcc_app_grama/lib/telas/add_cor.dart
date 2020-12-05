import 'package:tcc_app_grama/model/munsell_model.dart';
import 'package:tcc_app_grama/repository/munsell_repositores.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app_grama/widgets/corpoDrawer.dart';
import 'package:tcc_app_grama/widgets/drawerheader.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
        title: Text(
          "Cadastrar Cor",
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              drawerHeader(),
              corpoDrawer(context, "Cadastrar Cor"),
            ],
          ),
        ),
      ),
      body: _corpoTela(),
    );
  }

  Widget _corpoTela() {
    Widget _textFields(TextEditingController controller, String labelText) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 18),
            hintStyle: TextStyle(fontSize: 18),
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Campos com * são obrigatórios",
              style: TextStyle(
                color: Color.fromRGBO(250, 37, 62, 1.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          _textFields(_controllerHexa, "Hexa *"),
          _textFields(_controllerNotacao, "Notação da Tabela Munsell *"),
          _textFields(_controllerNutriente, "Nutriente *"),
          _textFields(_controllerNomeCor, "Nome da cor"),
          _botaoCadastrar(),
        ],
      ),
    );
  }

  Widget _botaoCadastrar() {
    return RaisedButton(
      color: Color.fromRGBO(138, 0, 16, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      textColor: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            size: 20,
          ),
          SizedBox(width: 10),
          Text(
            'Cadastrar',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: 10),
        ],
      ),
      onPressed: () {
        final String hexa = "#" + _controllerHexa.text;
        final String notacao = _controllerNotacao.text;
        final String nutriente = _controllerNutriente.text;
        final String nomeCor = _controllerNomeCor.text;

        (_controllerHexa.text.isEmpty &&
                _controllerNotacao.text.isEmpty &&
                _controllerNutriente.text.isEmpty)
            ? _notificacao()
            : _repository.cadastraMunsell(nutriente, notacao, hexa, nomeCor);
      },
    );
  }

  _notificacao() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Icon(
            Icons.warning,
            color: Color.fromRGBO(250, 37, 62, 1.0),
            size: 70,
          ),
          content: Text(
            "Preencha todos os campos obrigatórios",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
