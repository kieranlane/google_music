import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class settingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,),
            onPressed: () {Navigator.pop(context);}
        ),
        centerTitle: true,
        title: Text('Google Music Settings', style: TextStyle(color: Colors.white, fontSize: 25.0)),
        backgroundColor: Colors.black87,
      ),
      body: Container(child: Center(child:Text("Settings", style: TextStyle(color: Colors.white))), color: Colors.black)
    );
  }
}