import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'AppTheme.dart';
import 'Card.dart';
import 'ColorHelper.dart';
import 'UserInfo.dart';

void main() {
  runApp(BlocProvider<AppBloc>(
    builder: (context) => AppBloc(),
    child: MyApp(),));
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppBloc bloc = BlocProvider.of<AppBloc>(context);
    
    return BlocBuilder<AppBloc, ThemeData>(
      bloc: bloc,
      builder: (context, theme) {
        return MaterialApp(
                title: 'Flutter Tutorial',
                // home: TutorialHome(),
                home: TutorialHome(),
                theme: theme,
              );
      },
    );
  }
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
      backgroundColor: Theme.of(context).primaryColor,
      // body is the majority of the screen.
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          bar,
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                userSection,
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(DateFormat().add_yMMMd().format(DateTime.now()), style: TextStyle(color: hexToColor("#FFFFFF"), fontSize: 15,),),
                ),
              ],),
          ),
          haha,
      ],),)
    );
  }
}

