import 'package:todo/models/task.dart';
import 'package:todo/utils/app_theme.dart';

class TaskBucket {
  String title;
  String iconStr;
  List<Task> tasks;
  AppThemeStyle style;

  TaskBucket(this.style);
}