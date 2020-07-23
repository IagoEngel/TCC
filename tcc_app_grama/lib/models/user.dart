import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String nome;
  String email;

  DocumentReference reference;

  User({
    this.nome,
    this.email
  });

  factory User.fromSnapshot(DocumentSnapshot snapshot){
    User novoUser = User.fromJson(snapshot.data);
    novoUser.reference = snapshot.reference;
    return novoUser;
  }

  factory User.fromJson(Map<dynamic, dynamic> json) => _UserFromJson(json);

  Map<String, dynamic> toJson() => _UserToJson(this);

}

User _UserFromJson(Map<dynamic, dynamic> json){
  return User(
    nome: json['nome'] as String,
    email: json['email'] as String,
  );
}

Map<String,dynamic> _UserToJson(User instance) => <String, dynamic>{
  'nome': instance.nome,
  'email': instance.email,
};