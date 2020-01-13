import 'package:rxdart/subjects.dart';
import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/services/task_bucket_service.dart';
import 'package:todo/utils/app_theme.dart';

class HomeBloc {
  final _taskBucketsStreamController = BehaviorSubject<List<TaskBucketModel>>();
  final _countStreamController = BehaviorSubject<int>();

  Stream<int> get showCount => _countStreamController.stream;
  Stream<List<TaskBucketModel>> get taskBuckets => _taskBucketsStreamController.stream;

  HomeBloc() {
    TaskBucketDB().getDb();
    fetchData();
  }

  fetchData() {
    // var server = TaskBucketService();
    TaskBucketDB().fetchBuckets().then((buckets) {
      _taskBucketsStreamController.sink.add(buckets);
    });
  }

  getCount() {
     TaskBucketDB().fetchUnfinishedTasksCount().then((result) => _countStreamController.sink.add(result));
  }

  insert() {
    // var task = TaskBucketModel(id: 1, iconStr: "home", title: "asdfsadfsd", style: AppThemeStyle.home);
    // TaskBucketDB().insertTask(task).then(getCount());
  }

  dispose () {
    _taskBucketsStreamController.close();
    _countStreamController.close();
  }
}

class BucketBloc {

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

  void fetchTasks(int bucketId) {
    TaskBucketDB().fetchTasks(bucketId).then((result) => _tasksStreamController.sink.add(result));
  }

  dispose() {
    _tasksStreamController.close();
  }
}