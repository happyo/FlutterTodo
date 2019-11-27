import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/TaskBloc.dart';
import 'package:todo/utils/AppTheme.dart';

class CreateTaskPage extends StatelessWidget {
  final AppThemeStyle style;

  CreateTaskPage(this.style);

  final TaskBloc bloc = TaskBloc();

  Color get primaryColor => AppThemes.getThemeFromKey(style).primaryColor;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2016, 8),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
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
                      _selectDate(context);
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

