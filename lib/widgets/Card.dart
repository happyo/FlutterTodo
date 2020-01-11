import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/blocs/app_theme_bloc.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/pages/task_bucket_page.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/custom_router.dart';
import 'package:todo/widgets/bucket_progress_bar.dart';
import 'package:todo/widgets/circle_boarder_icon.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<List<TaskBucket>>(builder: (_, taskBuckets, __) => Container(
      height: 450.0,
      child: generatePageView(taskBuckets, context),));
  }

  Widget generatePageView(List<TaskBucket> taskBuckets, BuildContext context) {
    return taskBuckets == null ? Container() : PageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(
            initialPage: 0,
            viewportFraction: 0.8,
          ),
        // children: generateCards(taskBuckets),
        children: generateCards(taskBuckets),
        onPageChanged: (value) {
          Provider.of<AppThemeBloc>(context).changeStyle(taskBuckets[value].style);
        },
    );
  }

  List<Widget> generateCards(List<TaskBucket> taskBuckets) {
    return taskBuckets.map((taskBucket) => TaskCard(taskBucket)).toList();
  }
}

class TaskCard extends StatelessWidget {
  final TaskBucket taskBucket;

  TaskCard(this.taskBucket);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, ScaleRoute(page: Provider<TaskBucket>(create: (_) => taskBucket, child: TaskBucketPage(),)));
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
                      child: CircleBorderIcon(AppThemes.getImageStrWithStyle(taskBucket.style), AppThemes.getThemeFromKey(taskBucket.style).primaryColor)
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
                    Text("${taskBucket.tasks.length} Tasks", style: TextStyle(color: Colors.grey, fontSize: 25),),
                    SizedBox(height: 5,),
                    Text(AppThemes.getStringWithStyle(taskBucket.style), style: TextStyle(color: Colors.black, fontSize: 50),),
                    SizedBox(height: 10,),
                    Container(
                      child: TasksProgressBar(AppThemes.getThemeFromKey(taskBucket.style).primaryColor, taskBucket.taskProgress()),
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