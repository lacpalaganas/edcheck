import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:edcheck/gui/checker/checker_add_notes.dart';
import 'package:edcheck/gui/checker/test_api.dart';
import 'package:edcheck/gui/student/edit_assignment.dart';
import 'package:edcheck/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class CheckerAssignmentDetails extends StatefulWidget {
  const CheckerAssignmentDetails({Key? key}) : super(key: key);

  @override
  _CheckerAssignmentDetailsState createState() =>
      _CheckerAssignmentDetailsState();
}

class _CheckerAssignmentDetailsState extends State<CheckerAssignmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Assignment Details View'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestAPI(),
                      ));
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: ListView(
          children: [
            DetailsView(),
            CheckerNotes(),
          ],
        ));
  }
}

class DetailsView extends StatelessWidget {
  DetailsView({Key? key}) : super(key: key);
  final List<String> _imagesStudent = [
    "https://images.unsplash.com/photo-1600132806608-231446b2e7af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1532153975070-2e9ab71f1b14?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
                trailing: Chip(
              label: Text(
                'status here',
                style: TextStyle(
                  fontFamily: 'Trueno',
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              backgroundColor: Colors.green,
            )),
            const ListTile(
              title: Text(
                'Assignment Title Assignment Title Assignment Title Assignment Title',
                style: TextStyle(
                    fontFamily: 'Trueno',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Text(
                  'Subject',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.green,
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0),
                ),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 1.5,
              indent: 0.0,
              endIndent: 0.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 25.0, 14.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: GridView.builder(
                  primary: false,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                  ),
                  itemCount: _imagesStudent.length,
                  itemBuilder: (context, index) {
                    return new GestureDetector(
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                            image: DecorationImage(
                                image: NetworkImage(_imagesStudent[index]),
                                fit: BoxFit.cover),
                          )),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImagePreview(
                                imagePath: _imagesStudent[index])));
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 14,
            )
          ],
        ),
      ),
    );
  }
}

class CheckerNotes extends StatelessWidget {
  CheckerNotes({Key? key}) : super(key: key);
  final List<String> _imagesChecker = [
    "https://images.unsplash.com/photo-1600132806608-231446b2e7af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1532153975070-2e9ab71f1b14?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1600132806608-231446b2e7af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1600132806608-231446b2e7af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              tileColor: Colors.black54,
              title: Text(
                'Your notes',
                style: TextStyle(
                    fontFamily: 'Trueno',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: GridView.builder(
                  primary: false,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                  ),
                  itemCount: _imagesChecker.length,
                  itemBuilder: (context, index) {
                    return new GestureDetector(
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                            image: DecorationImage(
                                image: NetworkImage(_imagesChecker[index]),
                                fit: BoxFit.cover),
                          )),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImagePreview(
                                imagePath: _imagesChecker[index])));
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
