import 'package:flutter/material.dart';

import 'Card.dart';
import 'UserInfo.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    // home: TutorialHome(),
    home: TutorialHome(),
  ));
}

class TutorialHome extends StatelessWidget {
  final userSection = UserInfo();
  final haha = CardList();

  final bar = AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: ImageIcon(AssetImage("images/menu.png"), color: Colors.white,),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('TODO'),
        actions: <Widget>[
          IconButton(
            icon: ImageIcon(AssetImage("images/search.png"), color: Colors.white,),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: null,
      backgroundColor: hexToColor("#F77B67"),
      // body is the majority of the screen.
      body: Container(
        child: Column(
          children: <Widget>[
          bar,
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                userSection,
                haha,
              ],),)
      ],),)
    );
  }
}




Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}