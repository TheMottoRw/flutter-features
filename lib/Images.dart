import 'package:flutter/material.dart';

void main() => runApp(ImageApp());

class ImageApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image loader',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: LoadImage(title:'Load image'),
    );
  }
}
class LoadImage extends StatelessWidget{
  LoadImage({Key key,this.title}) : super(key:key);
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
            child: Image.asset('assets/asua.png'),
          ),
          Center(
            child: Image.network('https://picsum.photos/250?image=9'),
          )
        ],
      )

    );
  }
}