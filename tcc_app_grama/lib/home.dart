import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  
  Widget build(BuildContext context) {
  return new Scaffold(
    body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("assets/grama.jpeg"), fit: BoxFit.cover,),
          ),
        ),
        new Center(
          child: new Text("Grama"),
        )
      ],
    )
  );
}

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}