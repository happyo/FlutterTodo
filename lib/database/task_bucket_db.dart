import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_bucket.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:uuid/uuid.dart';

class TaskBucketDB {
  static final TaskBucketDB _singleton = TaskBucketDB._internal();

  TaskBucketDB._internal();
  
  factory TaskBucketDB() {
    return _singleton;
  }

  Database _database;

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    _database = await openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE buckets(id INTEGER PRIMARY KEY, title TEXT, iconStr Text, style INTEGER)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
    );
    didInit = true;
  }

  Future<List<TaskModel>> testAll() async {
    final List<Map<String, dynamic>> maps = await _database.query("buckets");

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  Future insertTask(TaskModel model) async {
    _database.insert("buckets", model.toMap());
  }

  List<TaskBucket> _all = _initBuckets();

  int fetchTodoTasksCount() {
    List<Task> allTasks = _all.map((bucket) => bucket.tasks).toList().fold([], (result, tasks) => result + tasks);
    
    return allTasks.where((task) => !task.finished).length;
  }

  List<TaskBucket> fetchBuckets() {
    return _all;
  }

  void createTask(Task task, Uuid bucketId) {
    var bucket = _all.firstWhere((bucket) => bucket.id == bucketId);

    if (bucket != null) {
      bucket.tasks.add(task);
    }
  }

  static List<TaskBucket> _initBuckets() {
    TaskBucket taskBucket = TaskBucket(AppThemeStyle.home);
    Task task1 = Task("asdfasdf");

    TaskBucket taskBucket1 = TaskBucket(AppThemeStyle.work);
    Task task2 = Task("asdfasdf");

    taskBucket.tasks = [task1, task2];
    taskBucket1.tasks = [task2];
    
    return [taskBucket, taskBucket1];
  }
}

class TaskModel {
  int id;
  String iconStr;
  String title;
  AppThemeStyle style;

  TaskModel({this.id, this.iconStr, this.title, this.style});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'iconStr': iconStr,
      'style': style.index,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    iconStr = map["iconStr"];
    title = map["title"];
    style = AppThemeStyle.values[map["style"]];
  }
}