import 'package:tcc_app_grama/model/munsell_model.dart';

class Historico{
  String data;
  MunsellModel analise;

  Historico({this.data, this.analise});

  Historico.fromJson(Map<String, dynamic>json){
    data = json['nome'];
    analise = json['analise'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['analise'] = this.analise;
    return data;
  }

}