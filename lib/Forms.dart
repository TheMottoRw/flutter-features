import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void mainApp() => runApp(FormApp());

class FormApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Form application",
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textSelectionHandleColor: Colors.black,
        textSelectionColor: Colors.black12,
        cursorColor: Colors.black,
        toggleableActiveColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
        ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          )
        )
      ),
      home: Scaffold(
        appBar: AppBar(
        title: Text("Form application"),
      ),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.0,12.0,12.0,7.0),
        child: MyFormApp(),
      ),
    ),
      ),
    );
  }
}
class MyFormApp extends StatefulWidget{
  MyFormApp({Key key}) : super(key: key);
  @override
  _MyFormAppState createState() => _MyFormAppState();
}

enum gender { Male,Female }
gender sex = gender.Male;
class _MyFormAppState extends State<MyFormApp>{
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
          "Fill this form to contiinue",
          style:TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
          ),
        const SizedBox(height: 10.0),
          Text("Names"),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "enter your names",
              contentPadding: EdgeInsets.only(left: 20.0,right: 3.0),
            ),
            validator: (String value){
              if(value.isEmpty){
                return "Names are required";
              }
              return null;
            },
    ),
          const SizedBox(height: 10.0),
          Text("Phone"),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "enter your phone",
              contentPadding: EdgeInsets.only(left: 20.0,right: 3.0),
            ),
            validator: (String value){
              if(value.isEmpty){
                return "Phone number is required";
              }
              return null;
            },
          ),
          Text("Gender"),
              ListTile(
                title: const Text("Male"),
                leading: Radio(
                  value: gender.Male,
                  groupValue: sex,
                  onChanged: (gender val){
                    setState(() {
                      sex = val;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Female"),
                leading: Radio(
                  value: gender.Female,
                  groupValue: sex,
                  onChanged: (gender val){
                    setState(() {
                      sex = val;
                    });
                  },
                ),
              ),
          const SizedBox(height: 10.0),
          Text("Password"),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "enter password",
              contentPadding: EdgeInsets.only(left: 20.0,right: 3.0),

            ),
            validator: (String value){
              if(value.isEmpty){
                return "Password are required";
              }
              return null;
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical:10.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text('I agree to terms of services and conditions'),
                )
              ]
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text("Register"),
              )
            ],
          )
        ],
      ),
    );
  }
  bool _submittable(){
    return _agreedToTOS;
  }
  void _submit(){
    _formKey.currentState.validate();
  }
  void _setAgreedToTOS(bool newVal){
    setState(() {
      _agreedToTOS = newVal;
    });
  }

}