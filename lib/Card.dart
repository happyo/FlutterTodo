import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/AppTheme.dart';

import 'ColorHelper.dart';

class CardList extends StatelessWidget {
  final taskCards = [TaskCard(AppThemeStyle.personal), TaskCard(AppThemeStyle.work), TaskCard(AppThemeStyle.home),];
  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    return Container(
      height: 450.0,
      // margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(
            initialPage: 0,
            viewportFraction: 0.8,
          ),
        children: taskCards,
        onPageChanged: (value) {
          appBloc.add(taskCards[value].style);
        },
    ),);
  }
}

class TaskCard extends StatelessWidget {
  final AppThemeStyle style;

  TaskCard(this.style);

  String getStringWithStyle(AppThemeStyle style) {
    switch (style) {
      case AppThemeStyle.personal:
        return "Personal";
      case AppThemeStyle.work:
        return "Work";
      case AppThemeStyle.home:
        return "Home"; 
      default :
        return "Personal";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          // ba
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[200], width: 2,),
                      ),
                      width: 50,
                      height: 50,
                      child: Container(
                        width: 18,
                        height: 18,
                        child: Center(child: Image.asset("images/user.png", color: AppThemes.getThemeFromKey(style).primaryColor, width: 18, height: 18, fit: BoxFit.fill),),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.asset("images/more.png", height: 16, width: 16,),
                ),
              ],),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("9 Tasks", style: TextStyle(color: Colors.grey, fontSize: 25),),
                  SizedBox(height: 5,),
                  Text(getStringWithStyle(style), style: TextStyle(color: Colors.black, fontSize: 50),),
                  SizedBox(height: 10,),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(child: SizedBox(
                          height: 2,
                          child: LinearProgressIndicator(
                            backgroundColor: hexToColor("#EEEEEE"),
                            valueColor: AlwaysStoppedAnimation<Color>(AppThemes.getThemeFromKey(style).primaryColor),
                            value: 0.8,
                          ),
                        ),),
                        SizedBox(width: 10),
                        Text("80%", style: TextStyle(color: hexToColor("#666666"), fontSize: 10,),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}