import 'package:flutter/material.dart';
import 'package:todo/AppTheme.dart';

class NewTask extends StatelessWidget {
  final AppThemeStyle style;

  NewTask(this.style);

  Color get primaryColor => AppThemes.getThemeFromKey(style).primaryColor;

  Future _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(2017),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2020)
    );
    if (picked != null) {
      
    }
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
                  Text("Design Work"),
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