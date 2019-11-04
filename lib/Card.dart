import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      // margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(
            initialPage: 1,
            viewportFraction: 0.8,
          ),
        children: <Widget>[
          TaskCard(), 
          TaskCard(),
          TaskCard(),
        ],
    ),);
  }
}

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          // ba
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[200], width: 2,),
                      ),
                      width: 50,
                      height: 50,
                      child: Container(
                        width: 18,
                        height: 18,
                        child: Center(child: Image.asset("images/user.png", color: Colors.blue, width: 18, height: 18, fit: BoxFit.fill),),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.asset("images/more.png", height: 16, width: 16,),
                ),
              ],),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("9 Tasks", style: TextStyle(color: Colors.grey, fontSize: 25),),
                  Text("Personal", style: TextStyle(color: Colors.black, fontSize: 50),),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(child: SizedBox(
                          height: 2,
                          child: LinearProgressIndicator(
                            backgroundColor: hexToColor("#EEEEEE"),
                            valueColor: AlwaysStoppedAnimation<Color>(hexToColor("#F77B67")),
                            value: 0.8,
                          ),
                        ),),
                        SizedBox(width: 10),
                        Text("80%", style: TextStyle(color: hexToColor("#666666"), fontSize: 10,),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}