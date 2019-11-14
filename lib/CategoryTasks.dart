import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/AppTheme.dart';
import 'package:todo/ColorHelper.dart';

import 'CircleBorderIcon.dart';
import 'TasksProgressBar.dart';

class CategoryTasks extends StatelessWidget {
  final AppThemeStyle style;

  CategoryTasks(this.style);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: ImageIcon(AssetImage("images/back.png"), color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          }),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
        child: Column(
          children: <Widget>[
            CategorySurvey(style),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TasksList(List<ListItem>.generate(
              1000, (i) => i % 6 == 0 ? HeadingItem("Heading $i") : MessageItem(i % 3 == 0 ? true : false, "Message body $i", i % 3 == 0 ? true : false,),
            ),),
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySurvey extends StatelessWidget {
  final AppThemeStyle style;

  CategorySurvey(this.style);

  Color get primaryColor => AppThemes.getThemeFromKey(style).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleBorderIcon(AppThemes.getImageStrWithStyle(style), primaryColor),
        SizedBox(height: 10,),
        Text("12 Tasks", style: TextStyle(color: Colors.grey, fontSize: 20),),
        SizedBox(height: 5,),
        Text("Work", style: TextStyle(color: hexToColor("#333333"), fontSize: 50),),
        SizedBox(height: 10,),
        TasksProgressBar(primaryColor, 0.8),
      ],
    );
  }
}

class TasksList extends StatelessWidget {
  final List<ListItem> items;

  TasksList(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) { 
        final item = items[index];
        if (item is MessageItem) {
          return Divider(
            color: Colors.grey,
            height: 1,
            indent: 30,
          );
        } else {
          return Container();
        }
        },
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is HeadingItem) {
          return HeadingCell(item);
        } else if (item is MessageItem) {
          return MessageCell(item);
        } else {
          return Container();
        }
      },
    );
  }
  
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class HeadingCell extends StatelessWidget {
  final HeadingItem headingItem;

  HeadingCell(this.headingItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      child: Text(headingItem.heading, style: TextStyle(color: Colors.grey, fontSize: 14)),
    );
  }
}

class MessageItem implements ListItem {
  final bool isSelected;
  final String detail;
  final bool hasClock;

  MessageItem(this.isSelected, this.detail, this.hasClock);
}

class MessageCell extends StatelessWidget {
  final MessageItem item;

  MessageCell(this.item);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 20,
          height: 20,
          child: Image.asset(item.isSelected ? "images/selected.png" : "images/unselected.png"),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(item.detail, style: TextStyle(color: Colors.black54, fontSize: 16),),
                ),
                Visibility(
                  visible: item.hasClock,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset("images/clock.png"),
                  ),
                ),
              ],
            ),
          ),),
      ],
    );
  }
}