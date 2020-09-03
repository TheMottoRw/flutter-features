import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Forms.dart';
import 'package:flutter_app/Helloworld.dart';
import 'package:flutter_app/Images.dart';
import 'package:flutter_app/Location.dart';
import 'package:flutter_app/Login.dart';
import 'package:flutter_app/Profile.dart';
import 'package:flutter_app/Browser.dart';
import 'package:flutter_app/Tabs.dart';
import 'package:flutter_app/ToDo.dart';
import 'package:flutter_app/Recording.dart';
import 'package:flutter_app/WebService.dart';
import 'package:flutter_app/contacts/Contacts.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/sqlite/appsqlite.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child:  Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked :',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child: Text('Profile')
            ),
            onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile()
                  )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('Hello world')
            ),
            onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainApp()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child: Text('Browsing')
            ),
            onPressed:  (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BrowserApp()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child: Text('Todo App')
            ),
            onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoList()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('Forms')
            ),
            onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormApp()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Container(
                height: 40,
                width: 300,
                alignment: Alignment.center,
                child: Text('Recorder')
            ),
            onPressed:  (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AudioRecording()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('Image')
            ),
            onPressed:  (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageApp()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('Chat UI')
            ),
            onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatApp()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('Login UI')
            ),
            onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyLoginApp()
                    )
                );
              },
            ),
          SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('Tabs')
            ),
            onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyTabApp()
                    )
                );
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('SQLite App')
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MySqliteApp()
                    )
                );
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                height: 40,
                width: 300,
                alignment: Alignment.center,
                child:Text('Webservice API'),
                ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebServiceApp()
                    )
                );
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Container(
                  height: 40,
                  width: 300,
                  alignment: Alignment.center,
                  child:Text('Contacts')
              ),
              onPressed:  (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyContactApp()
                    )
                );
              },
            ),
            SizedBox(height: 10.0,),
            RaisedButton(
              child: Container(
                height: 40,
                width: 300,
                alignment: Alignment.center,
                child:Text('GPS Location'),
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyLocationApp()
                    )
                );
              },
            ),

          ],
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
