import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/blocs/app_theme_bloc.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/color_helper.dart';
import 'package:todo/widgets/Card.dart';
import 'package:todo/widgets/user_info.dart';

void main() {
  runApp(BlocProvider<AppThemeBloc>(
    builder: (context) => AppThemeBloc(),
    child: MyApp(),));
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeBloc, ThemeData>(
      bloc: BlocProvider.of<AppThemeBloc>(context),
      builder: (context, theme) {
        return MaterialApp(
                title: 'Flutter Tutorial',
                home: TutorialHome(),
                theme: theme,
              );
      },
    );
  }
}

class TutorialHome extends StatelessWidget {
  final userSection = UserInfo();
  final haha = CardList([TaskCard(AppThemeStyle.home)]);

  final bar = AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: ImageIcon(AssetImage("images/menu.png"), color: Colors.white,),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('TODO', style: TextStyle(color: Colors.white),),
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
      appBar: bar,
      backgroundColor: Theme.of(context).primaryColor,
      // body is the majority of the screen.
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(50, 50, 0, 0),
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

