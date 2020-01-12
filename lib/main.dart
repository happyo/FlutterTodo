
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/blocs/app_theme_bloc.dart';
import 'package:todo/blocs/task_bucket_bloc.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/color_helper.dart';
import 'package:todo/widgets/Card.dart';
import 'package:todo/widgets/user_info.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppThemeBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeBloc = Provider.of<AppThemeBloc>(context);

    return StreamBuilder(
      stream: themeBloc.themeData,
      initialData: AppThemes.personalTheme,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Flutter Todo',
          home: HomePage(),
          theme: snapshot.data,
        ); 
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final taskBucketBloc = TaskBucketBloc();

  Widget userSection(TaskBucketBloc bloc) {
    return StreamBuilder(
      stream: taskBucketBloc.showCount,
      initialData: 0,
      builder: (context, snapshot) {
        return UserInfo(snapshot.data);
      },
    );
  }

  Widget generateHaha() {
    return StreamProvider<List<TaskBucket>>(
      create: (_) => taskBucketBloc.taskBuckets,
      child: CardList(),
    );
  }           

  Widget generateBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: ImageIcon(AssetImage("images/menu.png"), color: Colors.white,),
          tooltip: 'Navigation menu',
          onPressed: () => taskBucketBloc.getCount(),
        ),
        title: Text('TODO', style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: ImageIcon(AssetImage("images/search.png"), color: Colors.white,),
            tooltip: 'Search',
            onPressed: () => taskBucketBloc.insert(),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: generateBar(),
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
                userSection(taskBucketBloc),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(DateFormat().add_yMMMd().format(DateTime.now()), style: TextStyle(color: hexToColor("#FFFFFF"), fontSize: 15,),),
                ),
              ],),
          ),
          generateHaha(),
      ],),)
    );
  }
}

