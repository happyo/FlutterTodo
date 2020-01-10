import 'package:todo/models/task.dart';
import 'package:todo/utils/app_theme.dart';

class TaskBucket {
  String title;
  String iconStr;
  List<Task> tasks;
  AppThemeStyle style;

  TaskBucket(this.style);

  double taskProgress() {
    final length = tasks.length;
    if (length > 0) {
      return tasks.where((task) => task.finished).toList().length / tasks.length;
    } else {
      return 0;
    }
  }
}