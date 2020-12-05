import 'package:tcc_app_grama/model/munsell_model.dart';

class Historico{
  MunsellModel analise;

  Historico({this.analise});

  Historico.fromJson(Map<String, dynamic>json){
    analise = json['analise'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['analise'] = this.analise;
    return data;
  }

}