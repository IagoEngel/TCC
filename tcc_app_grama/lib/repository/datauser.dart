import 'package:tcc_app_grama/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository{

  CollectionReference collection = Firestore.instance.collection('usuario');

  Stream<QuerySnapshot> getStream(){
    return collection.snapshots();
  }

  Future<DocumentReference> addUser(User user){
    return collection.add(user.toJson());
  }

  updateUser(User user) async {
    await collection.document(user.reference.documentID).updateData(user.toJson());
  }

}