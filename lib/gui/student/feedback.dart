// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FeedbackTab extends StatefulWidget {
  @override
  State<FeedbackTab> createState() => FeedbackState();
}

class FeedbackState extends State<FeedbackTab> {


  void onFeedbackPress() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 14.0, right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Write to us',
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
                Container(
                    padding: EdgeInsets.only(left: 14.0, right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Experiencing an issue or have a question? Message us below.',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 4.0),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    maxLines: 8,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE6E6E6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ), labelText: ''),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text('Send Feedback'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(400.0, 60),
                      primary: Colors.green,
                      textStyle:
                      const TextStyle(fontSize: 20, fontFamily: 'Trueno'),
                    ),
                    onPressed: onFeedbackPress,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
