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
    join(await getDatabasesPath(), 'todo_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) async {
      await _createBucketTable(db);
      await _createTaskTable(db);
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
    );
    didInit = true;
  }

  Future _createBucketTable(Database db) {
    return db.transaction((txn) async {
      txn.execute("CREATE TABLE ${TaskBucketModel.tblTaskBucket} ("
        "${TaskBucketModel.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${TaskBucketModel.dbTitle} TEXT,"
        "${TaskBucketModel.dbIconStr} TEXT,"
        "${TaskBucketModel.dbStyle} INTEGER);");
      
      txn.insert(TaskBucketModel.tblTaskBucket, {
        TaskBucketModel.dbTitle: "Personal",
        TaskBucketModel.dbIconStr: "",
        TaskBucketModel.dbStyle: 0,
      });

      txn.insert(TaskBucketModel.tblTaskBucket, {
        TaskBucketModel.dbTitle: "Work",
        TaskBucketModel.dbIconStr: "",
        TaskBucketModel.dbStyle: 1,
      });

      txn.insert(TaskBucketModel.tblTaskBucket, {
        TaskBucketModel.dbTitle: "Home",
        TaskBucketModel.dbIconStr: "",
        TaskBucketModel.dbStyle: 2,
      });
    });
  }

  Future _createTaskTable(Database db) {
    return db.execute("CREATE TABLE ${TaskModel.tblTask} ("
        "${TaskModel.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${TaskModel.dbContent} TEXT,"
        "${TaskModel.dbDeadline} INTEGER,"
        "${TaskModel.dbFinished} INTEGER,"
        "${TaskModel.dbBucketId} INTEGER,"
        "FOREIGN KEY(${TaskModel.dbBucketId}) REFERENCES ${TaskBucketModel.tblTaskBucket}(${TaskBucketModel.dbId}) ON DELETE CASCADE);");
  }

  Future<List<TaskBucketModel>> testAll() async {
    final List<Map<String, dynamic>> maps = await _database.query("buckets");

    return List.generate(maps.length, (i) {
      return TaskBucketModel.fromMap(maps[i]);
    });
  }

  Future insertTask(TaskBucketModel model) async {
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

class TaskBucketModel {
  static final String tblTaskBucket = "buckets";
  static final String dbId = "id";
  static final String dbIconStr = "iconStr";
  static final String dbTitle = "title";
  static final String dbStyle = "style";

  int id;
  String iconStr;
  String title;
  AppThemeStyle style;

  TaskBucketModel({this.id, this.iconStr, this.title, this.style});

  Map<String, dynamic> toMap() {
    return {
      dbId: id,
      dbTitle: title,
      dbIconStr: iconStr,
      dbStyle: style.index,
    };
  }

  TaskBucketModel.fromMap(Map<String, dynamic> map) {
    id = map[dbId];
    iconStr = map[dbIconStr];
    title = map[dbTitle];
    style = AppThemeStyle.values[map[dbStyle]];
  }
}

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

  TaskModel({this.id, this.content, this.deadline, this.finished, this.bucketId});

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
    finished = map[dbFinished];
    bucketId = map[dbBucketId];
  }
}