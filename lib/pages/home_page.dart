import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/blocs/home_bloc.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/utils/color_helper.dart';
import 'package:todo/widgets/Card.dart';
import 'package:todo/widgets/user_info.dart';

class HomePage extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final homeBloc = Provider.of<HomeBloc>(context);
  //   homeBloc.fetchBuckets();
  // }

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: homeBar(),
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
                userSection(homeBloc),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(DateFormat().add_yMMMd().format(DateTime.now()), style: TextStyle(color: hexToColor("#FFFFFF"), fontSize: 15,),),
                ),
              ],),
          ),
          cardSection(homeBloc),
      ],),)
    );
  }

  Widget userSection(HomeBloc bloc) {
    return StreamBuilder(
      stream: bloc.showCount,
      initialData: 0,
      builder: (context, snapshot) {
        return UserInfo(snapshot.data);
      },
    );
  }

  Widget cardSection(HomeBloc bloc) {
    return StreamBuilder(
      stream: bloc.taskBuckets,
      initialData: List<TaskBucketModel>(),
      builder: (context, snapshot) {
        return CardList(snapshot.data);
      },
    );
  }           

  Widget homeBar() {
    return AppBar(
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
  }

}