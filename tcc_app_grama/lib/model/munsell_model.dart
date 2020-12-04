class MunsellModel {
  String nutriente;
  String notacao;
  String hexa;
  String nomecor;

  MunsellModel({
    this.nutriente,
    this.notacao,
    this.hexa,
    this.nomecor,
  });

  static MunsellModel fromMap(Map<String, dynamic> map) {
    
    if (map == null) return null;

    return MunsellModel(
      nutriente: map['nutriente'],
      notacao: map['notacao'],
      hexa: map['hexa'],
      nomecor: map['nomecor'],
    );

  }
}
