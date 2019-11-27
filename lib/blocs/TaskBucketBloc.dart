import 'package:rxdart/subjects.dart';
import 'package:todo/models/Task.dart';
import 'package:todo/models/TaskBucket.dart';

class TaskBucketBloc {
  final _taskFetcher = PublishSubject<List<TaskBucket>>();

  fetchData() {
    var bucket = TaskBucket();
    bucket.title = "home";
    var task = Task();
    task.content = "asdfasdfsadf";
    task.deadline = DateTime.now();
    bucket.tasks = [task];
    _taskFetcher.add([bucket]);
  }

  dispose() {
    _taskFetcher.close();
  }
}