import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class playingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(child: Center(child:Text("Playing", style: TextStyle(color: Colors.white))), color: Colors.black)
    );
  }
}