import 'dart:convert';
import 'dart:math';

import 'package:edcheck/gui/student/assignment_details.dart';
import 'package:edcheck/internal/assignment_data.dart';
import 'package:edcheck/internal/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_assignment.dart';

class UncheckedAssignments extends StatefulWidget {
  const UncheckedAssignments({Key? key}) : super(key: key);

  @override
  _UncheckedAssignmentsState createState() => _UncheckedAssignmentsState();
}

class _UncheckedAssignmentsState extends State<UncheckedAssignments> {
  List<String> title = [];
  List<String> subject = [];
  List<Widget> checkedWidget = [];
  List<AssignmentData> assignmentData = [];
  List<ImagePaths> imagePaths = [];
  List<ImagePaths> samePaths = [];

  late int items = 0;

  late Future<dynamic> futureAssignmentData;

  void initState() {
    super.initState();

    print("checked class");

    futureAssignmentData = requestData();
  }

  Future requestData() async {
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": "0328fjkasdocaksdut209029350293jrlMFLSAJDFPAOUW09IRW",
      "testVariable": "1",
    });
    var data = jsonDecode(response.body);
    assignJsonData(data);

    print(imagePaths[0].name.toString());
    print(assignmentData[0].title.toString());

    if (mounted) {
      setState(() {
        this.items = assignmentData.length;
      });
    }

    return assignmentData;
  }

  void assignJsonData(var data) {
    for (Map i in data) {
      int iterate = 0;
      if (i.containsKey("name")) {
        print("This contained a key name");

        imagePaths.insert(iterate, ImagePaths.fromJson(i));
        // for(int x = 0; x<i.length; x++){
        //   if(x==0){
        //     samePaths.insert(index, element)
        //   }
        // }
      } else {
        print("This contained a key title");
        assignmentData.insert(iterate, AssignmentData.fromJson(i));
        if (assignmentData[iterate].status.toString() == "3") {
          assignmentData.removeAt(iterate);
          //imagePaths.removeAt(iterate);
          iterate--;
        }
      }
      iterate++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureAssignmentData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listViewbuilder(context);
          }
          return Center(
              child: LoadingBouncingGrid.square(
            backgroundColor: Colors.green,
          ));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: Icon(Icons.addchart),
        label: Text(
          'Add Assignment',
          style: TextStyle(
              fontFamily: 'Trueno',
              fontWeight: FontWeight.normal,
              fontSize: 14.0),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAssignment(),
              ));
        },
      ),
    );
  }

  ListView listViewbuilder(BuildContext context) {
    return ListView.builder(
      itemCount: items,
      itemBuilder: (_, index) {
        // convert status code
        String status = assignmentData[index].status;
        Color statusColor = Colors.white;
        IconData statusIcon = Icons.ac_unit;
        if (status == '1') {
          statusIcon = Icons.access_time_filled;
          statusColor = Colors.blue;
        } else if (status == '2') {
          statusIcon = Icons.info;
          statusColor = Colors.orange;
        }
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: assignmentData[index].title,
                      style: TextStyle(
                          fontFamily: 'Trueno',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    WidgetSpan(
                      child: Transform.rotate(
                          angle: 50 * pi / 180,
                          child: Icon(
                            statusIcon,
                            size: 19,
                            color: statusColor,
                          )),
                    ),
                  ],
                ),
              ),
              subtitle: Text('Subject: ' + assignmentData[index].subject),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignmentDetails(
                          assignmentData: assignmentData[index],
                          imagePaths: imagePaths),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
