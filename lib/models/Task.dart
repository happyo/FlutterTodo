import 'package:intl/intl.dart';

class TaskModel {
  static final String tblTask = "tasks";
  static final String dbId = "id";
  static final String dbContent = "content";
  static final String dbDeadline = "deadline";
  static final String dbFinished = "finished";
  static final String dbBucketId = "bucketId";

  int id;
  String content;
  DateTime deadline;
  bool finished;
  int bucketId;

  TaskModel({this.id, this.content, this.deadline, this.finished = false, this.bucketId});

  Map<String, dynamic> toMap() {
    return {
      dbId: id,
      dbContent: content,
      dbDeadline: deadline.millisecondsSinceEpoch,
      dbFinished: finished,
      dbBucketId: bucketId,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map[dbId];
    content = map[dbContent];
    deadline = DateTime.fromMicrosecondsSinceEpoch(map[dbDeadline]);
    finished = map[dbFinished] == null ? false : map[dbFinished] == 1;
    bucketId = map[dbBucketId];
  }

  String timeString() {
    var formatter = DateFormat('yyyy-MM-dd');

    if (deadline != null) {
      String formatted = formatter.format(deadline);

      return formatted;
    } else {
      return "未限时";
    }
  }
}