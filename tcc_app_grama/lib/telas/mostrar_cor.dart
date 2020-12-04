import 'package:tcc_app_grama/model/munsell_model.dart';
import 'package:tcc_app_grama/repository/munsell_repositores.dart';
import 'package:flutter/material.dart';

class MostrarCor extends StatefulWidget {
  MostrarCor({Key key}) : super(key: key);

  @override
  _MostrarCorState createState() => _MostrarCorState();
}

class _MostrarCorState extends State<MostrarCor> {
  Future<List<MunsellModel>> munsellFuture;
  MunsellRepository _repository;
  TextEditingController _buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    _repository = MunsellRepository();
    munsellFuture = _repository.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exemplo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _buscaController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (_buscaController.text.isEmpty) {
                        munsellFuture = _repository.findAll();
                      } else {
                        munsellFuture =  _repository.buscaMunsell(_buscaController.text);
                      }
                    });
                  },
                  child: Text('Buscar'),
                ),
              )
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: this.munsellFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<MunsellModel>> snapshot) {
                print(snapshot.hasData);
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Text('Error: ${snapshot.error}'),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      var item = snapshot.data[index];
                      
                      return ListTile(
                        title: Text(item.notacao),
                        subtitle: Text(item.hexa),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
