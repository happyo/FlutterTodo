import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class TaskBloc extends Bloc<DateTime, String> {
  @override
  String get initialState => "";

  @override
  Stream<String> mapEventToState(DateTime event) async* {
    var str = DateFormat().add_yMMMd().format(event);
    yield str;
  }

  finishTask(Uuid taskId) {
    
  }
}