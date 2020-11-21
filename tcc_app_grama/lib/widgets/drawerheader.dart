import 'package:flutter/material.dart';

Widget drawerHeader() {
  return Container(
    height: AppBar().preferredSize.height,
    color: Color.fromRGBO(59, 39, 42, 1.0),
    child: DrawerHeader(
      child: Text(
        "Menu",
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    ),
  );
}