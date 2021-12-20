import 'package:edcheck/gui/checker/checker_assignment_details.dart';
import 'package:edcheck/gui/student/add_assignment.dart';
import 'package:edcheck/gui/student/assignment_details.dart';
import 'package:flutter/material.dart';

class CheckerCheckedAssignments extends StatefulWidget {
  const CheckerCheckedAssignments({Key? key}) : super(key: key);

  @override
  _CheckerCheckedAssignmentsState createState() =>
      _CheckerCheckedAssignmentsState();
}

class _CheckerCheckedAssignmentsState extends State<CheckerCheckedAssignments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listViewbuilder(context),
    );
  }

  ListView listViewbuilder(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Science $index ",
                      style: TextStyle(
                          fontFamily: 'Trueno',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.check_circle,
                        size: 19,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Text('Subject: Physics'),
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
