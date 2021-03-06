import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:todo/database/task_bucket_db.dart';
import 'package:todo/models/task.dart';

class TaskBloc {
  final _titleStreamController = BehaviorSubject<String>();
  final _dateStreamController = BehaviorSubject<DateTime>();

  Stream<String> get titleValue => _titleStreamController.stream;
  Stream<DateTime> get dateValue => _dateStreamController.stream;

  Stream<String> get dateString => dateValue.map((date) => DateFormat().add_yMMMd().format(date));

  Function(String) get changeTitle => _titleStreamController.sink.add;
  Function(DateTime) get changeDate => _dateStreamController.sink.add;

  Stream<bool> get submitValid => Observable.combineLatest2(titleValue, dateValue, (t, d) { 
    return t.length > 0 && d != null;
  });

  void updateTask(TaskModel task) {
    TaskBucketDB().updateTask(task);
  }

  void submit(int bucketId) {
    final content = _titleStreamController.value;
    final date = _dateStreamController.value;

    var task = TaskModel(content: content, deadline: date, bucketId: bucketId);

    TaskBucketDB().insertTask(task);
  }

  dispose() {
    _titleStreamController.close();
    _dateStreamController.close();
  }
}