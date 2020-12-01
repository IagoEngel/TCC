import 'package:flutter/material.dart';
import 'package:tcc_app_grama/telas/menu.dart';
import 'package:tcc_app_grama/telas/mostrar_cor.dart';
import 'package:tcc_app_grama/telas/add_cor.dart';
//import 'login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP TCC',
      debugShowCheckedModeBanner: false,
      home: MostrarCor(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}
