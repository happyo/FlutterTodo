import 'package:rxdart/subjects.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/services/task_bucket_service.dart';

class TaskBucketBloc {
  final _taskBucketPublisher = PublishSubject<List<TaskBucket>>();

  get taskBuckets => _taskBucketPublisher.stream;

  TaskBucketBloc() {
    fetchData();
  }

  fetchData() {
    var server = TaskBucketService();

    _taskBucketPublisher.add(server.fetchBuckets());
  }

  dispose () {
    _taskBucketPublisher.close();
  }
}