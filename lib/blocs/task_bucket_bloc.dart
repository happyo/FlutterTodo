import 'package:rxdart/subjects.dart';
import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task.dart';

class BucketBloc {
  final int bucketId;
  BucketBloc(this.bucketId) {
    fetchTasks();
  }

  final _tasksStreamController = BehaviorSubject<List<TaskModel>>();

  Stream<List<TaskModel>> get tasks => _tasksStreamController.stream;

  Stream<int> get allTasksCount => tasks.map((tasks) => tasks.length);
  Stream<double> get bucketProgress => tasks.map((tasks) {
    final allCount = tasks.length;
    if (allCount > 0) {
      double finishedCount = tasks.where((task) => task.finished).length.toDouble();
      return finishedCount / allCount.toDouble();
    } else {
      return 0;
    }
  });

  void fetchTasks() {
    TaskBucketDB().fetchTasks(bucketId).then((result) => _tasksStreamController.sink.add(result));
  }

  void updateTask(TaskModel task) {
    TaskBucketDB().updateTask(task).then((_) => fetchTasks());
  }

  void finishTask(int taskId, bool selected) {
    TaskBucketDB().finishTask(taskId, selected).then((_) => fetchTasks());
  }

  dispose() {
    _tasksStreamController.close();
  }
}