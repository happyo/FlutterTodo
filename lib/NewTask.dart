import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/AppTheme.dart';

class NewTask extends StatelessWidget {
  final AppThemeStyle style;

  NewTask(this.style);

  final NewTaskBloc bloc = NewTaskBloc();

  Color get primaryColor => AppThemes.getThemeFromKey(style).primaryColor;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime(2016, 8),
  //     firstDate: DateTime(2015, 8),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null) 
  //     bloc.add(picked);
  // }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      bloc.add(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("New Task"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, str) {
                      return Text(str);
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _selectTime(context);
                    },
                    child: Text('Show DateTime Picker',)
                  ),
                ],
              ),
            ),
            Container(
              height: 44,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                  icon: Icon(Icons.add, color: Colors.white,), 
                  color: Colors.blue, 
                  onPressed: () {
                    
                  },),
              ],)
            ),
          ],
        ),
      ),
    );
  }


}

class NewTaskBloc extends Bloc<TimeOfDay, String> {
  @override
  String get initialState => "";

  @override
  Stream<String> mapEventToState(TimeOfDay event) async* {
    yield "asdf";
  }


}