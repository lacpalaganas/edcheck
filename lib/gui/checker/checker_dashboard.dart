import 'package:edcheck/gui/checker/checker_assignment_details.dart';
import 'package:edcheck/gui/student/add_assignment.dart';
import 'package:edcheck/gui/student/assignment_details.dart';
import 'package:flutter/material.dart';

class CheckerDashboard extends StatefulWidget {
  const CheckerDashboard({Key? key}) : super(key: key);

  @override
  _CheckerDashboardState createState() => _CheckerDashboardState();
}

class _CheckerDashboardState extends State<CheckerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listViewbuilder(context),
    );
  }

  ListView listViewbuilder(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "History $index ",
                      style: TextStyle(
                          fontFamily: 'Trueno',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.access_time_filled,
                        size: 19,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Text('Subject: The Vietnam War '),
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
