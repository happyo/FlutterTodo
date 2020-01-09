import 'package:todo/models/task.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/utils/app_theme.dart';

class TaskBucketDB {
  static final TaskBucketDB _singleton = TaskBucketDB._internal();

  factory TaskBucketDB() {
    return _singleton;
  }

  TaskBucketDB._internal();

  List<TaskBucket> _all = _initBuckets();

  int fetchTodoTasksCount() {
    return 1;
  }

  List<TaskBucket> fetchBuckets() {
    return _all;
  }

  static List<TaskBucket> _initBuckets() {
    TaskBucket taskBucket = TaskBucket(AppThemeStyle.home);
    Task task1 = Task("asdfasdf");

    TaskBucket taskBucket1 = TaskBucket(AppThemeStyle.work);
    Task task2 = Task("asdfasdf");

    taskBucket.tasks = [task1, task2];
    taskBucket1.tasks = [task2];
    
    return [taskBucket, taskBucket1];
  }
}