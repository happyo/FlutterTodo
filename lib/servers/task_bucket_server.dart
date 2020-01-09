import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task_bucket.dart';

class TaskBucketServer {
  final _db = TaskBucketDB();
  
  List<TaskBucket> fetchBuckets() {
    return _db.fetchBuckets();
  }
}