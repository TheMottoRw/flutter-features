import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/message_model.dart';


class FavoriteContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            Text('Favorite Contact',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0
            ),),
          IconButton(
              icon: Icon(
                Icons.more_horiz,
              ),
              iconSize: 30.0,
              color: Colors.blueGrey,
              onPressed: () {},
        )
      ],
    ),
    ),
    Container(
    height: 120.0,
    child: ListView.builder(
    padding: EdgeInsets.only(left: 10.0),
    itemCount: Message.favorites.length,
    itemBuilder: (BuildContext context,int index){
    return Column(
    children: <Widget>[
    CircleAvatar(
    radius: 35.0,
    backgroundImage: AssetImage(Message.favorites[index].imageUrl),
    ),
    SizedBox(height: 6.0,),
    Text(Message.favorites[index].name),
    ],
    );
    },
    )
    ,
    )
    ]
    ,
    );
  }
}