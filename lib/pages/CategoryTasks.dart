import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/NewTask.dart';
import 'package:todo/pages/TasksList.dart';
import 'package:todo/utils/AppTheme.dart';
import 'package:todo/utils/ColorHelper.dart';
import 'package:todo/utils/ScaleRoute.dart';
import 'package:todo/widgets/CircleBorderIcon.dart';
import 'package:todo/widgets/TasksProgressBar.dart';

class CategoryTasks extends StatelessWidget {
  final AppThemeStyle style;

  CategoryTasks(this.style);
  Color get primaryColor => AppThemes.getThemeFromKey(style).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: ImageIcon(AssetImage("images/back.png"), color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          }),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
        child: Column(
          children: <Widget>[
            CategorySurvey(style),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TasksList(List<ListItem>.generate(
              1000, (i) => i % 6 == 0 ? HeadingItem("Heading $i") : MessageItem(i % 3 == 0 ? true : false, "Message body $i", i % 3 == 0 ? true : false,),
            ),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(FadeRoute(page: NewTask(style)));
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: primaryColor,
      ),
    );
  }
}

class CategorySurvey extends StatelessWidget {
  final AppThemeStyle style;

  CategorySurvey(this.style);

  Color get primaryColor => AppThemes.getThemeFromKey(style).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleBorderIcon(AppThemes.getImageStrWithStyle(style), primaryColor),
        SizedBox(height: 10,),
        Text("12 Tasks", style: TextStyle(color: Colors.grey, fontSize: 20),),
        SizedBox(height: 5,),
        Text("Work", style: TextStyle(color: hexToColor("#333333"), fontSize: 50),),
        SizedBox(height: 10,),
        TasksProgressBar(primaryColor, 0.8),
      ],
    );
  }
}

