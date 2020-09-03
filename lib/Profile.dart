import 'package:flutter/material.dart';

void main() => runApp(Profile());

class Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User profile',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyInfo(title:'Profiling'),
    );
  }
}
class MyInfo extends StatelessWidget{
  MyInfo({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body:  ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(2.0,10.0,2.0,10.0),
              children: <Widget>[
                MyProfile(image: 'asua.png',name:'Manzi Roger Asua',gender: 'Male',address: 'Sud,Kamonyi'),
                MyProfile(image: 'kabaka.png',name:'Igihozo Didier Kabaka',gender: 'Male',address: 'Musanze,Nord'),
                MyProfile(image: 'imenye_logo.png',name: 'Imenye platform',gender: 'Company',address: 'Telecom house'),
                MyProfile(image: 'asua.png',name:'Manzi Roger Asua',gender: 'Male',address: 'Sud,Kamonyi'),
                MyProfile(image: 'kabaka.png',name:'Igihozo Didier Kabaka',gender: 'Male',address: 'Musanze,Nord'),
                MyProfile(image: 'imenye_logo.png',name: 'Imenye platform',gender: 'Company',address: 'Telecom house'),
                MyProfile(image: 'asua.png',name:'Manzi Roger Asua',gender: 'Male',address: 'Sud,Kamonyi'),
                MyProfile(image: 'kabaka.png',name:'Igihozo Didier Kabaka',gender: 'Male',address: 'Musanze,Nord'),
                MyProfile(image: 'imenye_logo.png',name: 'Imenye platform',gender: 'Company',address: 'Telecom house'),
                MyProfile(image: 'asua.png',name:'Manzi Roger Asua',gender: 'Male',address: 'Sud,Kamonyi'),
                MyProfile(image: 'kabaka.png',name:'Igihozo Didier Kabaka',gender: 'Male',address: 'Musanze,Nord'),
                MyProfile(image: 'imenye_logo.png',name: 'Imenye platform',gender: 'Company',address: 'Telecom house'),
            ],
          ),
    );
  }
}
class MyProfile extends StatelessWidget{
  MyProfile({Key key,this.image,this.name,this.gender,this.address}) : super(key:key);
  final String image,name,gender,address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/'+this.image),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(this.name,
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(this.gender),
                    Text("Location:"+this.address),
                    GestureDetector(
                      child: new Text("More"),
                      onTap: (){
                        _showDialog(context,'tapped',this.name,this.address);
                      },
                      onDoubleTap: (){
                        _showDialog(context,'double tapped',this.name,this.address);
                      },
                      onLongPress: (){
                        _showDialog(context,'long pressed',this.name,this.address);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _showDialog(BuildContext context,event,name,address){
    showDialog(
      context: context,
      builder: (BuildContext){
        return AlertDialog(
          title: Text('User details '+event),
          content: new Text(name+"\n"+" live in "+address),
          actions: <Widget>[
            new FlatButton(
                onPressed: (){
              Navigator.of(context).pop();
            }, child: new Text("Close"))
          ],
        );
      }
    );
  }
}