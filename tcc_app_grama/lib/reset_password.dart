
import 'package:flutter/material.dart';

import 'login.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('Recupere Sua Senha'),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 60, left: 40, right: 40),
            color: Colors.white,
            child: ListView(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 200,
                            height: 200,
                            child:
                                Image.asset("assets/reset-password-icon.png"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Esqueceu sua senha?",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Por favor, informe o E-mail associado a sua conta que enviaremos um link com as instruções para restauração de sua senha.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "E-mail",
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                    "Enviar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                 onPressed: () =>
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  ),
                ),
              ),
            ),
                          ],
                        )),
                  ]),
            ])));
  }
}
