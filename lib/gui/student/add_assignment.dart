import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:edcheck/internal/assignment_id.dart';
import 'package:edcheck/internal/request_handler.dart';
import 'package:edcheck/internal/subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class AddAssignment extends StatefulWidget {
  final String id;
  final String email;
  const AddAssignment({Key? key, required this.id, required this.email})
      : super(key: key);

  @override
  _AddAssignmentState createState() => _AddAssignmentState(id, email);
}

class _AddAssignmentState extends State<AddAssignment> {
  final String userid;
  final String email;
  _AddAssignmentState(this.userid, this.email);

  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  String chapterSelected = "1";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
              "Chapter 1: Linear Equations, Inequalities and Applications"),
          value: "1"),
      DropdownMenuItem(
          child: Text("Chapter 2: Linear Equations, Graphs, and Functions"),
          value: "2"),
      DropdownMenuItem(
          child: Text("Chapter 3: Systems of Linear Equations"), value: "3"),
      DropdownMenuItem(
          child: Text(
              "Chapter 4: Exponents, Polynomials, and Polynomial Functions"),
          value: "4"),
      DropdownMenuItem(child: Text("Chapter 5: Factoring"), value: "5"),
      DropdownMenuItem(
          child: Text("Chapter 6: Rational Expressions and Functions"),
          value: "6"),
      DropdownMenuItem(
          child: Text("Chapter 7: Roots, Radicals, and Root Functions"),
          value: "7"),
    ];
    return menuItems;
  }

  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  Future<void> onSavePress() async {
    RequestHandler handler =
        RequestHandler("e1eb74bc5148970392bd89e2d0822f29e27fc9c17");

    var chapters = chapterSelected;
    var title = titleController.text;
    var subject = subjectController.text;
    var description = descriptionController.text;
    var id = "";
    var studentSchool = "";
    var gradeLevel = "";
    var assignNumber = "";
    var status = "1";
    var checkerNotes = "";
    var checkerUserId = "";
    var created_at = DateTime.now().millisecondsSinceEpoch;
    var updated_at = DateTime.now().millisecondsSinceEpoch;

    var data =
        await handler.getAssignId("e1eb74bc5148970392bd89e2d0822f29e27fc9c15");
    var jsonData = jsonDecode(data);
    List<AssignmentId> assignmentIds = [];
    for (Map accs in jsonData) {
      int iterate = 0;
      assignmentIds.insert(iterate, AssignmentId.fromJson(accs));
      //print("id: " + accounts[iterate].id);
      iterate++;
    }
    print("last assignNum from DB = " + assignmentIds[0].assignNumber);
    int lastAssignNum = int.parse(assignmentIds[0].assignNumber.toString());
    int nextAssignNum = lastAssignNum + 1;
    print("Next assignNum = " + nextAssignNum.toString());

    print("last uniqueId from DB = " + assignmentIds[0].id);
    int lastUniqueId = int.parse(assignmentIds[0].id.toString());
    int nextUniqueId = lastUniqueId + 1;
    print("Next uniqueId = " + nextUniqueId.toString());

    handler.newAssignment(
        nextUniqueId.toString(),
        title,
        chapters,
        studentSchool,
        gradeLevel,
        subject,
        description,
        userid,
        nextAssignNum.toString(),
        status,
        checkerNotes,
        checkerUserId,
        created_at.toString(),
        updated_at.toString());

    print("-----------------");
    print("id: " + nextUniqueId.toString());
    print("title: " + title);
    print("chapters: " + chapters.toString());
    print("studentSchool: " + studentSchool);
    print("gradeLevel: " + gradeLevel);
    print("subject: " + subject);
    print("userId: " + userid);
    print("assignNumber: " + nextAssignNum.toString());
    print("status: " + status.toString());
    print("checkerNotes: " + checkerNotes);
    print("checkerUserId: " + checkerUserId.toString());
    print("created_at: " + created_at.toString());
    print("updated_at: " + updated_at.toString());
  }

  void onUploadPress() {}

  Widget buildGridView() {
    return SizedBox(
      height: 250,
      child: GridView.count(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Stack(
            children: <Widget>[
              AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    print('delete image from List');
                    setState(() {
                      print('set new state of images');
                      images.removeAt(index);
                    });
                  },
                  child: Icon(
                    Icons.disabled_by_default_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  void initState() {}

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Add Assignment View'),
          actions: <Widget>[
            IconButton(onPressed: onSavePress, icon: Icon(Icons.save))
          ],
        ),
        body: Stack(children: <Widget>[
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 34.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 00.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    child: Text(
                                      "Add Assignment",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Trueno',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28.0),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Divider(
                                    height: 40.0,
                                    thickness: 1.5,
                                    indent: 32.0,
                                    endIndent: 32.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextField(
                                        controller: titleController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE6E6E6),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          labelText: 'Title',
                                        ),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TypeAheadFormField(
                                        direction: AxisDirection.up,
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          controller: subjectController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE6E6E6),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            labelText: 'Subjects',
                                          ),
                                        ),
                                        suggestionsCallback: (pattern) {
                                          return Subjects.getSuggestions(
                                              pattern);
                                        },
                                        noItemsFoundBuilder: (context) =>
                                            Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  'No subjects found.',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                        onSuggestionSelected: (suggestion) {
                                          this.subjectController.text =
                                              suggestion.toString();
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            title: Text(suggestion.toString()),
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE6E6E6),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          labelText: 'Chapters'),
                                      isExpanded: true,
                                      value: chapterSelected,
                                      items: dropdownItems,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          chapterSelected = newValue!;
                                        });
                                      },
                                    ),
                                  ),
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
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          labelText: 'Description'),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: Text('Upload Images'),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(360.0, 60),
                                      primary: Colors.green,
                                      textStyle: const TextStyle(
                                          fontSize: 20, fontFamily: 'Trueno'),
                                    ),
                                    onPressed: loadAssets,
                                  ),
                                  buildGridView(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }
}
