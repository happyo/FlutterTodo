import 'package:flutter/material.dart';

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