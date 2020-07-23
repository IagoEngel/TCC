import 'package:flutter/material.dart';
import 'package:tcc_app_grama/services/auth.dart';
import 'package:tcc_app_grama/signup.dart';
import 'package:tcc_app_grama/telas/tela_inicial.dart';

class Login extends StatefulWidget {
  int qtdTentativas = 1;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Já tem uma conta? Entre!'),
          backgroundColor: Colors.green,
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
                      image: AssetImage("assets/login.png"),
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
                    color: Colors.green,
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
                          fontSize: 20,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaInicial()));
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
