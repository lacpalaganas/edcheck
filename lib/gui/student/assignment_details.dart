import 'dart:io';
import 'package:edcheck/internal/assignment_data.dart';
import 'package:edcheck/internal/image_paths.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;

import 'package:dotted_border/dotted_border.dart';
import 'package:edcheck/gui/student/edit_assignment.dart';
import 'package:edcheck/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_downloader/image_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AssignmentDetails extends StatefulWidget {
  final AssignmentData assignmentData;
  final List<ImagePaths> imagePaths;
  const AssignmentDetails(
      {Key? key, required this.assignmentData, required this.imagePaths})
      : super(key: key);

  @override
  _AssignmentDetailsState createState() =>
      _AssignmentDetailsState(assignmentData, imagePaths);
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  final AssignmentData assignmentData;
  final List<ImagePaths> imagePaths;
  _AssignmentDetailsState(this.assignmentData, this.imagePaths);

  int _progress = 0;
  @override
  void initState() {
    super.initState();

    ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

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
                        builder: (context) => EditAssignment(),
                      ));
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: ListView(
          children: [
            DetailsView(assignmentData, imagePaths),
            CheckerNotes(assignmentData, imagePaths),
          ],
        ));
  }
}

class DetailsView extends StatelessWidget {
  final AssignmentData assignmentData;
  final List<ImagePaths> imagePaths;
  DetailsView(this.assignmentData, this.imagePaths, {Key? key})
      : super(key: key) {
    print("pasing images to details");
    for (int i = 0; i < imagePaths.length; i++) {
      if (assignmentData.assignNumber.toString() ==
          imagePaths[i].assignNumber.toString()) {
        _imagesStudent.add(edcheckURL + imagePaths[i].imagePath.toString());
      }
    }
    print(_imagesStudent);
  }
  final List<String> _imagesStudent = [];

  final edcheckURL = "https://edcheck.app/getchecked/";
  // void initState() {
  //   initState();
  //   print("pasing images to details");
  //   for (int i = 0; i < imagePaths.length; i++) {
  //     if (assignmentData.assignNumber.toString() ==
  //         imagePaths[i].assignNumber.toString()) {
  //       _imagesStudent.add(edcheckURL + imagePaths[i].imagePath.toString());
  //     }
  //   }
  //   print(_imagesStudent);
  // }

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
            ListTile(
              title: Text(
                assignmentData.title.toString(),
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
                    assignmentData.description.toString(),
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
                    return GestureDetector(
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
                            builder: (context) => GestureDetector(
                                  onLongPress: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.grey,
                                        content: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Download",
                                                  style: TextStyle(
                                                      fontFamily: 'Trueno',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () async {
                                                          try {
                                                            var imageId = await ImageDownloader
                                                                .downloadImage(
                                                                    _imagesStudent[
                                                                        index]);
                                                            // Fluttertoast
                                                            //     .showToast(
                                                            //   msg:
                                                            //       'Image Saved',
                                                            //   toastLength: Toast
                                                            //       .LENGTH_SHORT,
                                                            //   gravity:
                                                            //       ToastGravity
                                                            //           .BOTTOM,
                                                            //   timeInSecForIosWeb:
                                                            //       1,
                                                            //   backgroundColor:
                                                            //       Colors.white,
                                                            //   textColor:
                                                            //       Colors.black,
                                                            // );

                                                          } on PlatformException catch (error) {
                                                            print(error);
                                                          }
                                                        }),
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.download,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ImagePreview(
                                      imagePath: _imagesStudent[index]),
                                )));
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
  final AssignmentData assignmentData;
  final List<ImagePaths> imagePaths;
  CheckerNotes(this.assignmentData, this.imagePaths, {Key? key}) {
    print("pasing images to details");
    for (int i = 0; i < imagePaths.length; i++) {
      if (assignmentData.assignNumber.toString() ==
          imagePaths[i].assignNumber.toString()) {
        _imagesChecker.add(edcheckURL + imagePaths[i].imagePath.toString());
      }
    }
    print(_imagesChecker);
  }

  final edcheckURL = "https://edcheck.app/getchecked/";
  final List<String> _imagesChecker = [];
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
                'Checker notes',
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
                    return GestureDetector(
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
