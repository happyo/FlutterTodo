import 'package:rxdart/subjects.dart';
import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/services/task_bucket_service.dart';
import 'package:todo/utils/app_theme.dart';

class TaskBucketBloc {
  final _taskBucketPublisher = BehaviorSubject<List<TaskBucketModel>>();
  final _countStreamController = BehaviorSubject<int>();

  Stream<int> get showCount => _countStreamController.stream;
  Stream<List<TaskBucketModel>> get taskBuckets => _taskBucketPublisher.stream;

  TaskBucketBloc() {
    TaskBucketDB().getDb();
    fetchData();
  }

  fetchData() {
    // var server = TaskBucketService();
    TaskBucketDB().fetchBuckets().then((buckets) {
      _taskBucketPublisher.sink.add(buckets);
    });
  }

  getCount() {
     TaskBucketDB().fetchUnfinishedTasksCount().then((result) => _countStreamController.sink.add(result));
  }

  insert() {
    var task = TaskBucketModel(id: 1, iconStr: "home", title: "asdfsadfsd", style: AppThemeStyle.home);
    TaskBucketDB().insertTask(task).then(getCount());
  }

  dispose () {
    _taskBucketPublisher.close();
    _countStreamController.close();
  }
}