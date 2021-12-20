// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FeedbackTab extends StatefulWidget {
  @override
  State<FeedbackTab> createState() => FeedbackState();
}

class FeedbackState extends State<FeedbackTab> {
  bool agreement = false;
  final nameControler = TextEditingController();
  final phoneNumberControler = TextEditingController();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  final schoolControler = TextEditingController();

  void onFeedbackPress() {}

  void onAgreeChanged(bool? agreeCheckBox) {
    setState(() {
      agreement = agreeCheckBox ?? true;
      print("Check Box: " + onAgreeChanged.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Feedback Form',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Divider(color: Colors.black),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Experiencing an issue or have a question?',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Message us below.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  maxLines: 8,
                  controller: phoneNumberControler,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Feedback'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: onFeedbackPress,
                  child: Text('Send Feedback'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
