import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class profilePage extends StatelessWidget {
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
        title: Text('Google Music Profile', style: TextStyle(color: Colors.white, fontSize: 25.0)),
        backgroundColor: Colors.black87,
      ),
        body: Container(child: Center(child:Text("Profile", style: TextStyle(color: Colors.white))), color: Colors.black)
    );
  }
}