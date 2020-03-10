import 'package:flutter/material.dart';
import 'package:todo/blocs/task_bloc.dart';
import 'package:todo/utils/app_theme.dart';

class CreateTaskPage extends StatelessWidget {
  final AppThemeStyle style;
  final int bucketId;

  CreateTaskPage(this.style, this.bucketId);

  final TaskBloc bloc = TaskBloc();

  Color get primaryColor => AppThemes.getThemeFromKey(style).primaryColor;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2050),
    );

    if (picked != null) 
      bloc.changeDate(picked);
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
                  titleTextField(bloc),
                  datePicker(bloc),
                ],
              ),
            ),
            bottomAddButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget titleTextField(TaskBloc bloc) {
    return StreamBuilder(
      stream: bloc.titleValue,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeTitle,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            labelText: "Content",
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget datePicker(TaskBloc bloc) {
    return StreamBuilder(
      stream: bloc.dateString,
      initialData: "Show date picker",
      builder: (context, snapshot) {
        return FlatButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context);
          },
          child: Text(snapshot.data),
        );
      },
    );
  }

  Widget bottomAddButton(TaskBloc bloc) {
    return StreamBuilder( 
      stream: bloc.submitValid,
      initialData: false,
      builder: (context, snapshot) {
        return Container(
          height: 44,
          color: snapshot.data ? primaryColor : Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add, color: Colors.white,), 
                onPressed: snapshot.data ? () {
                  bloc.submit(bucketId);
                  Navigator.pop(context);
                } : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

