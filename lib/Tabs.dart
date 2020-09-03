import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyTabApp());

class MyTabApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab bar navigation',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyTabHome(),
    );
  }
}
class MyTabHome extends StatefulWidget{
  @override
  _MyTabHomeState createState() => _MyTabHomeState();
}
class _MyTabHomeState extends State{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Phone OS Giant'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.desktop_windows ),
                text: 'Windows'),
              Tab(
                icon: Icon(Icons.android),
                text: 'Android',
              ),
              Tab(
                icon: Icon(Icons.phone_iphone),
                text: 'IOS',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(child: Text('Windows phone')),
            Center(child: Text('Android phone')),
            Center(child: Text('IOS Phone'),),
          ],
        ),
      ),
    );
  }
}