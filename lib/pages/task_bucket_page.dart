import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/blocs/task_bucket_bloc.dart';
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

  final TaskBucketModel taskBucket;

  TaskBucketPage(this.taskBucket);

  @override
  Widget build(BuildContext context) {
    final bucketBloc = Provider.of<BucketBloc>(context);

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
                  surveySection(bucketBloc),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: tasksSection(bucketBloc),
                  ),
                ],
              ),
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(FadeRoute(page: CreateTaskPage(taskBucket.style, taskBucket.id)));
              bucketBloc.fetchTasks();
            },
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: primaryColor(taskBucket.style),
          ),
    );
  }

  Widget surveySection(BucketBloc bloc) {
    return CategorySurvey(taskBucket);
  }

  Widget tasksSection(BucketBloc bloc) {
    return StreamBuilder(
      stream: bloc.tasks,
      initialData: List<TaskModel>(),
      builder: (context, snapshot) {
        return generateTaskList(snapshot.data, bloc);
      },
    );
  }

  Widget generateTaskList(List<TaskModel> tasks, BucketBloc bloc) {
    var map = groupBy(tasks, (task) => task.timeString());
    var items = List<ListItem>();

    map.forEach((key, value) {
      items.add(HeadingItem("$key"));
      items.addAll(value.map((task) => MessageItem(task.finished, task.content, task.deadline != null, task.id)));
    });

    return TasksList(items, onSelect: (taskId, selected) => bloc.finishTask(taskId, selected),);
  }
}

class CategorySurvey extends StatelessWidget {
  final TaskBucketModel taskBucket;

  CategorySurvey(this.taskBucket);

  Color get primaryColor => AppThemes.getThemeFromKey(taskBucket.style).primaryColor;

  @override
  Widget build(BuildContext context) {
    final bucketBloc = Provider.of<BucketBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleBorderIcon(AppThemes.getImageStrWithStyle(taskBucket.style), primaryColor),
        SizedBox(height: 10,),
        tasksCountLabel(bucketBloc),
        SizedBox(height: 5,),
        Text(taskBucket.title, style: TextStyle(color: hexToColor("#333333"), fontSize: 50),),
        SizedBox(height: 10,),
        progressBar(bucketBloc),
      ],
    );
  }

  Widget tasksCountLabel(BucketBloc bloc) {
    return StreamBuilder(
      stream: bloc.allTasksCount,
      initialData: 0,
      builder: (context, snapshot) {
        return Text("${snapshot.data} Tasks", style: TextStyle(color: Colors.grey, fontSize: 20),);
      },
    );
  }

  Widget progressBar(BucketBloc bloc) {
    return StreamBuilder(
      stream: bloc.bucketProgress,
      initialData: 0.0,
      builder: (context, snapshot) {
        return TasksProgressBar(primaryColor, snapshot.data);
      },
    );
  }
}

