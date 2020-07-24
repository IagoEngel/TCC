import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInEmailPasswd(String email, String passwd) async{
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: passwd)).user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOff() async{
    await _auth.signOut();
  }

  Future createEmailPasswd(String email, String passwd) async {
    try{
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: email, password: passwd)).user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}