import 'package:todo/models/task.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:uuid/uuid.dart';

class TaskBucketDB {
  static final TaskBucketDB _singleton = TaskBucketDB._internal();

  factory TaskBucketDB() {
    return _singleton;
  }

  TaskBucketDB._internal();

  List<TaskBucket> _all = _initBuckets();

  int fetchTodoTasksCount() {
    List<Task> allTasks = _all.map((bucket) => bucket.tasks).toList().fold([], (result, tasks) => result + tasks);
    
    return allTasks.where((task) => !task.finished).length;
  }

  List<TaskBucket> fetchBuckets() {
    return _all;
  }

  void createTask(Task task, Uuid bucketId) {
    var bucket = _all.firstWhere((bucket) => bucket.id == bucketId);

    if (bucket != null) {
      bucket.tasks.add(task);
    }
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