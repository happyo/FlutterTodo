import 'package:todo/utils/app_theme.dart';

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