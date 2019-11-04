import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(width: 250, color: Colors.yellow,
            child: TaskCard(), 
          ),
        ],
    ),);
  }
}

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(controller: PageController(),);
  }
}

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: Card(
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
                Image.asset("images/more.png", height: 16, width: 16,),
              ],),
              ),
              Column(
                children: <Widget>[
                  Text("data"),
                  Text("data"),
                  LinearProgressIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}