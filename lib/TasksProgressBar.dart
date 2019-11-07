import 'package:flutter/material.dart';

import 'ColorHelper.dart';

class TasksProgressBar extends StatelessWidget {
  final Color progressColor;
  final double value; // 0-1.0

  TasksProgressBar(this.progressColor, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
            children: <Widget>[
              Expanded(child: SizedBox(
                height: 2,
                child: LinearProgressIndicator(
                  backgroundColor: hexToColor("#EEEEEE"),
                  valueColor: AlwaysStoppedAnimation<Color>(this.progressColor),
                  value: value,
                ),
              ),),
              SizedBox(width: 10),
              Text((this.value * 100).toInt().toString() + "%", style: TextStyle(color: hexToColor("#666666"), fontSize: 10,),),
            ],
          );
  }
  
}