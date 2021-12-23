// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CheckerList extends StatefulWidget {
  @override
  _CheckerList createState() => new _CheckerList();
}

class _CheckerList extends State<CheckerList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(height: 32.0),
        Container(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Our Checkers',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Trueno',
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0),
                ),
                Text(
                  '.',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Trueno',
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0),
                ),
              ],
            )),
        SizedBox(height: 16.0),
        GridView.count(
          crossAxisCount: 2,
          primary: false,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 4.0,
          shrinkWrap: true,
          children: <Widget>[
            _buildCard('Ringo', 1),
            _buildCard('Adam', 2),
            _buildCard('Ricky', 3),
            _buildCard('Leonard', 4),
            _buildCard('Leonard', 5),
          ],
        )
      ],
    );
  }

  //reusable card widget
  Widget _buildCard(String name, int cardIndex) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Stack(children: <Widget>[
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/images/edcheckLogo.png'))),
              ),
            ]),
            SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Trueno',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0),
            SizedBox(height: 20.0),
            Expanded(
                child: Container(
              width: 175.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
            ))
          ],
        ),
        margin: cardIndex.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
  }
}
