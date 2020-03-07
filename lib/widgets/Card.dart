import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo/blocs/app_theme_bloc.dart';
import 'package:todo/blocs/home_bloc.dart';
import 'package:todo/blocs/task_bucket_bloc.dart';
import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/pages/task_bucket_page.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/custom_router.dart';
import 'package:todo/widgets/bucket_progress_bar.dart';
import 'package:todo/widgets/card.dart';
import 'package:todo/widgets/circle_boarder_icon.dart';

class CardList extends StatelessWidget {
  final List<TaskBucketModel> taskBuckets;

  CardList(this.taskBuckets);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: cardPageView(taskBuckets, context),
    );
  }

  Widget cardPageView(List<TaskBucketModel> taskBuckets, BuildContext context) {
    return taskBuckets == null ? Container() : PageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(
            initialPage: 0,
            viewportFraction: 0.8,
          ),
        // children: generateCards(taskBuckets),
        children: cards(taskBuckets),
        onPageChanged: (value) {
          Provider.of<AppThemeBloc>(context).changeStyle(taskBuckets[value].style);
        },
    );
  }

  List<Widget> cards(List<TaskBucketModel> taskBuckets) {
    var result = taskBuckets.map((taskBucket) { 
      return Provider(
        create: (_) => BucketBloc(taskBucket.id),
        dispose: (_, bloc) => bloc.dispose,
        child: TaskCard(taskBucket),
      );
      // return TaskCard(taskBucket);
    }).toList();
    return result;
  }
}

class TaskCard extends StatelessWidget {
  final TaskBucketModel taskBucket;

  TaskCard(this.taskBucket);

  @override
  Widget build(BuildContext context) {
    final bucketBloc = Provider.of<BucketBloc>(context);

    return SizedBox(
      // height: 200,
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(context, ScaleRoute(page: Provider(
            create: (_) => bucketBloc,
            child: TaskBucketPage(taskBucket),
          )));

          final homeBloc = Provider.of<HomeBloc>(context);
          homeBloc.fetchUnfinishedTasksCount();
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
                    countLabel(bucketBloc),
                    SizedBox(height: 5,),
                    Text(AppThemes.getStringWithStyle(taskBucket.style), style: TextStyle(color: Colors.black, fontSize: 50),),
                    SizedBox(height: 10,),
                    progressBar(bucketBloc),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget countLabel(BucketBloc bloc) {
    return StreamBuilder(
      stream: bloc.allTasksCount,
      initialData: 0,
      builder: (context, snapshot) {
        return Text("${snapshot.data} Tasks", style: TextStyle(color: Colors.grey, fontSize: 25),);
      },
    );
  }

  Widget progressBar(BucketBloc bloc) {
    return StreamBuilder(
      stream: bloc.bucketProgress,
      initialData: 0.0,
      builder: (context, snapshot) {
        return Container(
          child: TasksProgressBar(AppThemes.getThemeFromKey(taskBucket.style).primaryColor, snapshot.data),
        );
      },
    ); 
  }
}