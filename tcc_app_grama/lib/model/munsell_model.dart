class MunsellModel {
  String hexa;
  String descricao;
  String mineral;
  String formula;
  String nomecor;

  MunsellModel({
    this.hexa,
    this.descricao,
    this.mineral,
    this.formula,
    this.nomecor,
  });

  static MunsellModel fromMap(Map<String, dynamic> map) {
    
    if (map == null) return null;

    return MunsellModel(
      hexa: map['hexa'],
      descricao: map['descricao'],
      mineral: map['mineral'],
      formula: map['formula'],
      nomecor: map['nomecor']
    );

  }
}
