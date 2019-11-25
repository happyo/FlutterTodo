import 'package:flutter/material.dart';

class CircleBorderIcon extends StatelessWidget {
  final String imageStr;
  final Color themeColor;

  CircleBorderIcon(this.imageStr, this.themeColor);

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200], width: 2,),
            ),
            width: 50,
            height: 50,
            child: Container(
              width: 18,
              height: 18,
              child: Center(child: Image.asset(this.imageStr, color: this.themeColor, width: 18, height: 18, fit: BoxFit.fill),),
            ),
          );
  }
  
}