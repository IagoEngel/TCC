import 'package:flutter/material.dart';
import 'package:tcc_app_grama/services/auth.dart';
import 'package:tcc_app_grama/signup.dart';
import 'package:tcc_app_grama/telas/tela_inicial.dart';
import 'package:tcc_app_grama/repository/datauser.dart';
import 'package:tcc_app_grama/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  int qtdTentativas = 1;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User user = new User();
  final AuthService _auth = AuthService();
  UserRepository repository = UserRepository();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Center(
            child: new Text(
              'Já tem uma conta? Entre!',
              style: TextStyle(fontSize: 24),
            ),
          ),
          backgroundColor: Color.fromRGBO(59, 39, 42, 1.0),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment(0.0, 1.15),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage("assets/iconLogin.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Se não possui uma conta, Cadastre-se!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _textFieldEmail(),
                _textFieldSenha(),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(59, 39, 42, 1.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Text(
                        "Acessar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        dynamic result = await _auth.signInEmailPasswd(
                            txtEmail.text, txtSenha.text);
                        if (result == null) {
                          print('error signing in');
                        } else {
                          print('USUÁRIO LOGADO');
                        }
                        await _getUser(txtEmail.text)
                            .then((QuerySnapshot docs) {
                          user.email = docs.documents[0].data['email'];
                          user.nome = docs.documents[0].data['nome'];
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaInicial(user: user)));
                      },
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: FlatButton(
                      child: Text(
                        "Cadastre-se",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  _getUser(String email) {
    return Firestore.instance
        .collection('usuario')
        .where('email', isEqualTo: email)
        .getDocuments();
  }

  Widget _textFieldEmail() {
    return TextFormField(
      // autofocus: true,
      controller: txtEmail,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _textFieldSenha() {
    return TextFormField(
      // autofocus: true,
      controller: txtSenha,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Senha",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }
}
