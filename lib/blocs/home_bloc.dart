
import 'package:rxdart/rxdart.dart';
import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task_bucket.dart';

class HomeBloc {
  final _taskBucketsStreamController = BehaviorSubject<List<TaskBucketModel>>();
  final _countStreamController = BehaviorSubject<int>();

  Stream<int> get showCount => _countStreamController.stream;
  Stream<List<TaskBucketModel>> get taskBuckets => _taskBucketsStreamController.stream;

  fetchBuckets() {
    // var server = TaskBucketService();
    TaskBucketDB().fetchBuckets().then((buckets) {
      _taskBucketsStreamController.sink.add(buckets);
    });
  }

  fetchUnfinishedTasksCount() {
     TaskBucketDB().fetchUnfinishedTasksCount().then((result) => _countStreamController.sink.add(result));
  }

  dispose () {
    _taskBucketsStreamController.close();
    _countStreamController.close();
  }
}
