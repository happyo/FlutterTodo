import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final int taskCount;

  UserInfo(this.taskCount);

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
          UserImage(),
          Text("Hello, Jane.", style: TextStyle(color: Colors.white, fontSize: 36),),
          Text("Looks like feel good.\nYou have $taskCount tasks to do today.", style: TextStyle(color: Colors.white54, fontSize: 15),),
    ],),);
  }
}

class UserImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: CircleAvatar(backgroundImage: AssetImage("images/setting.png"),),
    );
  }
}