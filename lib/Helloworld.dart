import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello world',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title:'Home page'),
    );
  }
}
class MyHomePage extends StatelessWidget{
  MyHomePage({Key key,this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            child: Text("Back to home"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          Center(
            child: Text(
              'Hello to the world',
              style: TextStyle(
                backgroundColor: Colors.blue,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontSize: 16,
              ),
            ),
          ),
        ],

      )
    );
  }
}