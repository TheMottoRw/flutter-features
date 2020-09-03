import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';//invoke platform spec code
import 'package:http/http.dart' as http;

void main () => runApp(BrowserApp());

class BrowserApp extends StatefulWidget{
  BrowserApp({Key key}) : super(key: key);

  @override
  _MyBrowserState createState() => _MyBrowserState();

}

Future<RequestData> fetchData() async {
  final response = await http.get("http://192.168.64.102/RUT/imenye/api/v1/users.php?cate=specialist");
  if(response.statusCode == 200){
    return RequestData.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception("Failed to load data"+response.statusCode.toString());
  }
}
class _MyBrowserState extends State{
  Future<RequestData> futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Load data',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

    home: Scaffold(
      appBar: AppBar(
        title: Text('Fetch data example'),
      ),
      body: Center(
        child: FutureBuilder<RequestData>(
          future: futureData,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data.names);
    } else if(snapshot.hasError){
              return Text("${snapshot.error}");
    }
            return CircularProgressIndicator();
    }
        ),
      ),
    )
    );
  }
}

class RequestData {
  final String id,names,phone;
  RequestData({this.id,this.names,this.phone});

  factory RequestData.fromJson(Map<String,dynamic> json){
    return RequestData(
      id: json['id'],
      names: json['names'],
      phone: json['phone'],
    );
  }
}