import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(WebServiceApp());

class WebServiceApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webservice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyWebserviceApp(),
    );
  }
}
class MyWebserviceApp extends StatefulWidget{

  _MyWebserviceAppState createState() => _MyWebserviceAppState();
}

class _MyWebserviceAppState extends State<MyWebserviceApp>{
  String title = "Wassup man";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webservice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Fetch'),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: (){
                _getRequest();
              },
            ),
            RaisedButton(
              child: Text('Post'),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: (){
                _postRequest();
              },
            ),
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

  void _getRequest() async{
    String url = 'http://192.168.64.102/flutter/request.php?cate=Gateway';
    Response response = await get(url);

    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String dataBody = response.body;
    setState(() {
      title = dataBody;
    });
    print("HTTP Response ContentType "+contentType+" Data "+dataBody+" Status code $statusCode");
  }

  dynamic _postRequest() async{
    String url = 'http://192.168.64.102/flutter/request.php?cate=post';
    Map<String,String> js = {"title":"Hello asua developer","body":"We really appreciate your work","id":'12'};

    Response response = await post(url,headers: null,body: js);
    int statusCode = response.statusCode;
    dynamic json = jsonDecode(response.body);
    setState(() {
      title = json['title'];
    });
    print("Response data "+json['title']+" Status $statusCode");
    return json;
  }


  void _jsonRequest(){

  }
}