import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/app_theme_bloc.dart';
import 'package:todo/pages/task_bucket_page.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/custom_router.dart';
import 'package:todo/widgets/bucket_progress_bar.dart';
import 'package:todo/widgets/circle_boarder_icon.dart';

class CardList extends StatelessWidget {
  List<TaskCard> taskCards;

  CardList(this.taskCards); 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(
            initialPage: 0,
            viewportFraction: 0.8,
          ),
        children: taskCards,
        onPageChanged: (value) {
          BlocProvider.of<AppThemeBloc>(context).add(taskCards[value].style);
        },
    ),);
  }
}

class TaskCard extends StatelessWidget {
  final AppThemeStyle style;

  TaskCard(this.style);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, ScaleRoute(page: TaskBucketPage(style)));
        },
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
                      child: CircleBorderIcon(AppThemes.getImageStrWithStyle(style), AppThemes.getThemeFromKey(style).primaryColor)
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
                    Text(AppThemes.getStringWithStyle(style), style: TextStyle(color: Colors.black, fontSize: 50),),
                    SizedBox(height: 10,),
                    Container(
                      child: TasksProgressBar(AppThemes.getThemeFromKey(style).primaryColor, 0.6),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}