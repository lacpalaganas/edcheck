import 'package:edcheck/gui/checker/checker_assignment_details.dart';
import 'package:edcheck/gui/student/add_assignment.dart';
import 'package:edcheck/gui/student/assignment_details.dart';
import 'package:flutter/material.dart';

class CheckerInReview extends StatefulWidget {
  const CheckerInReview({Key? key}) : super(key: key);

  @override
  _CheckerInReviewState createState() => _CheckerInReviewState();
}

class _CheckerInReviewState extends State<CheckerInReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listViewbuilder(context),
    );
  }

  ListView listViewbuilder(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Mathematics $index ",
                      style: TextStyle(
                          fontFamily: 'Trueno',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.info,
                        size: 19,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Text('Subject: Trigonometry '),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckerAssignmentDetails(),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
