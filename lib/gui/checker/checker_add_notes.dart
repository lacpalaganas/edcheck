import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:photo_view/photo_view.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class CheckerAddNotes extends StatefulWidget {
  const CheckerAddNotes({Key? key}) : super(key: key);

  @override
  _CheckerAddNotesState createState() => _CheckerAddNotesState();
}

class _CheckerAddNotesState extends State<CheckerAddNotes> {
  String? statusSelected;

  final reviewNotesControler = TextEditingController();
  final checkedNotesControler = TextEditingController();
  bool isVisibleReviewNotes = false;
  bool isVisibleCheckedNotes = false;

  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  Widget buildGridView() {
    return SizedBox(
      height: 250,
      child: GridView.count(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
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
  void initState() {
    statusSelected = "1";
  }

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
          title: Text('Add Notes View'),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.save))
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
                                      "Change Status",
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
                                  RadioListTile(
                                      title: Text(
                                        'Open',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Trueno',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0),
                                      ),
                                      value: '1',
                                      groupValue: statusSelected,
                                      onChanged: statusChanged),
                                  RadioListTile(
                                      title: Text(
                                        'In Review',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Trueno',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0),
                                      ),
                                      value: '2',
                                      groupValue: statusSelected,
                                      onChanged: statusChanged),
                                  RadioListTile(
                                      title: Text(
                                        'Checked',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Trueno',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0),
                                      ),
                                      value: '3',
                                      groupValue: statusSelected,
                                      onChanged: statusChanged),
                                  SizedBox(height: 15.0),
                                  Visibility(
                                    visible: isVisibleReviewNotes,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextField(
                                        controller: reviewNotesControler,
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE6E6E6),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          labelText: 'Review Notes',
                                          prefixIcon: Icon(Icons.message),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isVisibleCheckedNotes,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: checkedNotesControler,
                                            maxLines: 4,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFE6E6E6),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              labelText: 'Checked Notes',
                                              prefixIcon: Icon(Icons.notes),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          ElevatedButton(
                                            child: Text('Upload Images'),
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(400.0, 60),
                                              primary: Colors.green,
                                              textStyle: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Trueno'),
                                            ),
                                            onPressed: loadAssets,
                                          ),
                                          buildGridView()
                                        ],
                                      ),
                                    ),
                                  ),
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

  void onSavePress() {}

  void onUploadPress() {}

  void statusChanged(String? value) {
    setState(() {
      statusSelected = value;
      if (statusSelected == "2") {
        isVisibleReviewNotes = false;
      } else {
        isVisibleReviewNotes = false;
      }

      if (statusSelected == "3") {
        isVisibleCheckedNotes = true;
      } else {
        isVisibleCheckedNotes = false;
      }

      print(value);
    });
  }
}
