import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_bucket.dart';

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

  Future<List<TaskBucketModel>> fetchBuckets() async {
    final List<Map<String, dynamic>> maps = await _database.query(TaskBucketModel.tblTaskBucket);
    
    return maps.map((m) => TaskBucketModel.fromMap(m)).toList();
  }

  Future<int> fetchUnfinishedTasksCount() async {
    var x = await _database.rawQuery("SELECT count(*) FROM ${TaskModel.tblTask} WHERE finished = 0;");
    int count = Sqflite.firstIntValue(x);
    return count;
  }

  Future<List<TaskModel>> fetchTasks(int bucketId) async {
    final List<Map> maps = await _database.query(TaskModel.tblTask, where: "bucketId = ?", whereArgs: [bucketId]);

    var list = maps.map((m) => TaskModel.fromMap(m)).toList();
    list.sort((a, b) {
      return a.deadline.compareTo(b.deadline);
    });

    return list;
  }

  Future insertTask(TaskModel task) {
    return _database.insert(TaskModel.tblTask, task.toMap());
  }

  Future updateTask(TaskModel task) {
    return _database.update(TaskModel.tblTask, task.toMap());
  }

  Future finishTask(int taskId, bool selected) {
    return _database.rawUpdate("UPDATE ${TaskModel.tblTask} SET finished = ? WHERE id = ?;", [selected ? 1 : 0, taskId]);
  }
}