import 'package:uuid/uuid.dart';

class Task {
  Uuid id;
  String content;
  DateTime deadline;
  bool finished;
}