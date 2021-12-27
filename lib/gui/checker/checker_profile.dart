// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'dart:ffi';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CheckerProfile extends StatefulWidget {
  final Function(String) callback;
  CheckerProfile(this.callback);

  @override
  State<CheckerProfile> createState() => ProfileState();
}

class ProfileState extends State<CheckerProfile> {
  bool rememberMe = false;
  final nameControler = TextEditingController();
  final emailControler = TextEditingController();
  final aboutControler = TextEditingController();

  final accountNameControler = TextEditingController();
  final accountNumberControler = TextEditingController();
  final bankNameControler = TextEditingController();
  final routingNumberControler = TextEditingController();

  final feedbackControler = TextEditingController();

  final List<Widget> imageSource = <Widget>[];
  int sourceIndex = 0;

  @override
  void initState() {
    super.initState();
    sourceIndex = 0;
    imageSource.insert(0, networkImage());
  }

  Widget networkImage() {
    return CircleAvatar(
      backgroundImage: NetworkImage(
          'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
    );
  }

  Widget localImage() {
    return CircleAvatar(backgroundImage: FileImage(_image));
  }

  void onUpdatePress() {}

  void onLogoutPress() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        title: 'Do you want to logout?',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        backgroundColor: Colors.white,
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Future.delayed(Duration(seconds: 1), () {
            widget.callback("homepage");
          });
        });
    //
  }

  ImagePicker picker = ImagePicker();
  var _image;

  Future<void> onCameraPress() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    Navigator.pop(context);
    setState(() {
      _image = File(image!.path);

      if (imageSource.length == 3) {
        imageSource.removeAt(2);
        imageSource.insert(1, localImage());
        sourceIndex = 1;
      } else {
        imageSource.insert(1, localImage());
        sourceIndex = 1;
      }
    });
  }

  Future<void> onGalleryPress() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    setState(() {
      _image = File(image!.path);
      if (imageSource.length == 3) {
        imageSource.removeAt(2);
        imageSource.insert(1, localImage());
        sourceIndex = 1;
      } else {
        imageSource.insert(1, localImage());
        sourceIndex = 1;
      }
    });
  }

  void onUploadPress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            width: double.infinity,
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        label: Text('Camera'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: const TextStyle(
                              fontSize: 20, fontFamily: 'Trueno'),
                        ),
                        onPressed: onCameraPress),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        label: Text('Gallery'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: const TextStyle(
                              fontSize: 20, fontFamily: 'Trueno'),
                        ),
                        onPressed: onGalleryPress),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                          'Edit Your Profile',
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
                SizedBox(height: 8.0),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      imageSource.elementAt(sourceIndex),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: onUploadPress,
                            elevation: 2.0,
                            fillColor: Color(0xFFF5F6F9),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.green,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: nameControler,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE6E6E6),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.assignment_ind)),
                    )),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: 'abc@gmail.com',
                    readOnly: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: aboutControler,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelText: 'About',
                      prefixIcon: Icon(Icons.analytics_sharp),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(5.0),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(color: Colors.black, width: 0),
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     child: ExpansionTile(
                //       title: Text(
                //         'Bank Details',
                //         style: TextStyle(fontSize: 16, fontFamily: 'Trueno'),
                //       ),
                //       subtitle: Text('See your bank account details'),
                //       children: <Widget>[
                //         Padding(
                //           padding: EdgeInsets.all(10),
                //           child: TextFormField(
                //             readOnly: false,
                //             autofocus: false,
                //             controller: accountNameControler,
                //             decoration: InputDecoration(
                //               border: OutlineInputBorder(
                //                 borderSide: BorderSide(
                //                   color: Color(0xFFE6E6E6),
                //                   width: 2,
                //                 ),
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               labelText: 'Account Name',
                //               prefixIcon: Icon(Icons.chrome_reader_mode),
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.all(10),
                //           child: TextFormField(
                //             readOnly: false,
                //             autofocus: false,
                //             controller: accountNumberControler,
                //             decoration: InputDecoration(
                //               border: OutlineInputBorder(
                //                 borderSide: BorderSide(
                //                   color: Color(0xFFE6E6E6),
                //                   width: 2,
                //                 ),
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               labelText: 'Account Number',
                //               prefixIcon: Icon(Icons.format_list_numbered),
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.all(10),
                //           child: TextFormField(
                //             readOnly: false,
                //             autofocus: false,
                //             controller: bankNameControler,
                //             decoration: InputDecoration(
                //               border: OutlineInputBorder(
                //                 borderSide: BorderSide(
                //                   color: Color(0xFFE6E6E6),
                //                   width: 2,
                //                 ),
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               labelText: 'Bank Name',
                //               prefixIcon: Icon(Icons.home_work_sharp),
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.all(10),
                //           child: TextFormField(
                //             readOnly: false,
                //             autofocus: false,
                //             controller: routingNumberControler,
                //             decoration: InputDecoration(
                //               border: OutlineInputBorder(
                //                 borderSide: BorderSide(
                //                   color: Color(0xFFE6E6E6),
                //                   width: 2,
                //                 ),
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               labelText: 'Routing Number',
                //               prefixIcon: Icon(Icons.confirmation_number_sharp),
                //             ),
                //           ),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: <Widget>[
                //             ElevatedButton(
                //               child: const Text('Update Bank Details'),
                //               style: ElevatedButton.styleFrom(
                //                 primary: Colors.black,
                //               ),
                //               onPressed: () {/* ... */},
                //             ),
                //             const SizedBox(width: 15),
                //           ],
                //         ),
                //         SizedBox(height: 9)
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'Write to us',
                        style: TextStyle(fontSize: 16, fontFamily: 'Trueno'),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: feedbackControler,
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE6E6E6),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              labelText: 'Feedback',
                              prefixIcon: Icon(Icons.message),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              child: const Text('Send Feedback'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                              onPressed: () {/* ... */},
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                        SizedBox(height: 9)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: Text('Update'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400.0, 60),
                        primary: Colors.green,
                        textStyle:
                            const TextStyle(fontSize: 20, fontFamily: 'Trueno'),
                      ),
                      onPressed: onUpdatePress),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400.0, 60),
                        primary: Colors.black,
                        textStyle:
                            const TextStyle(fontSize: 20, fontFamily: 'Trueno'),
                      ),
                      onPressed: onLogoutPress),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
