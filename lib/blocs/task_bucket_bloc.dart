import 'package:rxdart/subjects.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/utils/app_theme.dart';

class TaskBucketBloc {
  final _taskBucketPublisher = PublishSubject<List<TaskBucket>>();

  get taskBuckets => _taskBucketPublisher.stream;

  fetchData() {
    TaskBucket taskBucket = TaskBucket(AppThemeStyle.home);
    Task task1 = Task("asdfasdf");
    taskBucket.tasks = [task1];

    _taskBucketPublisher.add([taskBucket]);
  }

  dispose () {
    _taskBucketPublisher.close();
  }
}