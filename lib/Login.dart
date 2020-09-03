import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: MyLoginApp(),
    )
  );
}

class MyLoginApp extends StatefulWidget{
  @override
  _State createState() => _State();
}

class _State extends State{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login app'),
      ),
      body: LoginUI(),
    );
  }
}
class LoginUI extends StatelessWidget{

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Learn signin',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 30
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
                controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          FlatButton(
            onPressed: (){

            },
            textColor: Colors.green,
            child: Text('Forgot butotn'),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text('Login'),
              onPressed: (){
                print("Username is "+nameController.text);
                print("Password is "+passwordController.text);
              },
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text('Does not have account'),
                FlatButton(
                  textColor: Colors.green,
                  child: Text(
                    'Signup',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: (){

                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        ],
      ),
    );
  }
}