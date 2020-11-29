import 'package:tcc_app_grama/model/munsell_model.dart';
import 'package:dio/dio.dart';
class MunsellRepository {
  Future<List<MunsellModel>> findAll() {
     Dio dio = new Dio();
    return dio.get('http://192.168.1.105:3333/tabela').then((res) {
     print(res.data);
      return res.data.map<MunsellModel>((c) => MunsellModel.fromMap(c)).toList()
          as List<MunsellModel>;
    }).catchError((err) => print(err));
  }

  Future<List<MunsellModel>> findFilter(String nome) {
    Dio dio = new Dio();
    return dio
        .get('http://192.168.1.105:3333/solo/diferenca/?hexa1=$nome')
        .then((res) {
      return res.data.map<MunsellModel>((c) => MunsellModel.fromMap(c)).toList()
          as List<MunsellModel>;
    });
  }

 Future<String> cadastraMunsell( String hexa,String descricao,String mineral,String formula, String munsell,String nomecor) async {
    Dio dio = new Dio();
    print(hexa);
       print(descricao);
          print(mineral);
             print(formula);
               print(munsell);
                print(nomecor);

   Response response = await dio.post('http://192.168.1.105:3333/tabela/',data:{"hexa":hexa,"descricao":descricao, "mineral":mineral,"formula":formula,"munsell":munsell,"nomecor":nomecor});
    print(response);
  }


  
  Future<List<MunsellModel>> buscaMunsell(String hexa) {
    Dio dio = new Dio();
    return dio
        .get('http://192.168.1.105:3333/solo/diferenca/?hexa1=$hexa')
        .then((res) {
      return res.data.map<MunsellModel>((c) => MunsellModel.fromMap(c)).toList()
          as List<MunsellModel>;
    });
  }
}
