import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/pages/create_task_page.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/color_helper.dart';
import 'package:todo/utils/custom_router.dart';
import 'package:todo/widgets/bucket_progress_bar.dart';
import 'package:todo/widgets/circle_boarder_icon.dart';
import 'package:todo/widgets/task_list.dart';
import 'package:collection/collection.dart';

class TaskBucketPage extends StatelessWidget {
  Color primaryColor(AppThemeStyle style) {
    return AppThemes.getThemeFromKey(style).primaryColor;
  } 

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskBucketModel>(
        builder: (_, taskBucket, __) => Scaffold(
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
                  CategorySurvey(taskBucket),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: generateTaskList([]),
                  ),
                ],
              ),
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(FadeRoute(page: CreateTaskPage(taskBucket.style, taskBucket.id)));
            },
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: primaryColor(taskBucket.style),
          ),
    ),);
  }

  Widget generateTaskList(List<Task> tasks) {
    var map = groupBy(tasks, (task) => task.timeString());
    var items = List<ListItem>();

    map.forEach((key, value) {
      items.add(HeadingItem("$key"));
      items.addAll(value.map((task) => MessageItem(task.finished, task.content, task.deadline != null)));
    });

    return TasksList(items);
  }
}

class CategorySurvey extends StatelessWidget {
  final TaskBucketModel taskBucket;

  CategorySurvey(this.taskBucket);

  Color get primaryColor => AppThemes.getThemeFromKey(taskBucket.style).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleBorderIcon(AppThemes.getImageStrWithStyle(taskBucket.style), primaryColor),
        SizedBox(height: 10,),
        Text("0 Tasks", style: TextStyle(color: Colors.grey, fontSize: 20),),
        SizedBox(height: 5,),
        Text(AppThemes.getStringWithStyle(taskBucket.style), style: TextStyle(color: hexToColor("#333333"), fontSize: 50),),
        SizedBox(height: 10,),
        TasksProgressBar(primaryColor, 0.1),
      ],
    );
  }
}

