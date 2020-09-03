import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(LocationApp());

class LocationApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Location service',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyLocationApp(),
    );
  }
}
class MyLocationApp extends StatefulWidget{

  _MyLocationAppState createState() => _MyLocationAppState();
}

class _MyLocationAppState extends State<MyLocationApp>{
  String title = "Wassup man";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    getCurrentLoc().then((value){
      print("Data "+value.toString());
      setState(() {
        title = value.toString();
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ) ,
    );
  }

  Future getCurrentLoc() async{
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("Posistion eg "+position.toJson().toString());
    return position.toJson();
  }
}