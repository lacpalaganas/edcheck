// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Profile extends StatefulWidget  {
  final Function(String) callback;
  Profile(this.callback);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile>  {
  bool rememberMe = false;
  final nameControler = TextEditingController();
  final mobileNumberControler = TextEditingController();
  final schoolControler = TextEditingController();

  void onUpdatePress() {}

  void onLogoutPress() {
    widget.callback("homepage");
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
                SizedBox(height: 4.0),
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
                          prefixIcon: Icon(Icons.assignment_ind)
                        ),
                    )),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: mobileNumberControler,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE6E6E6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_iphone),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    initialValue: 'abc@gmail.com',
                    readOnly: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      border:  OutlineInputBorder(
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
                    controller: schoolControler,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE6E6E6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        labelText: 'School',
                      prefixIcon: Icon(Icons.school_rounded),),
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
                    onPressed:  onUpdatePress
                  ),
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
                      onPressed:  onLogoutPress
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ElevatedButton(
                //       child: Text('Subscribe to add assignments'),
                //       style: ElevatedButton.styleFrom(
                //         fixedSize: const Size(400.0, 60),
                //         primary: Color(0xff6772e5),
                //         textStyle:
                //         const TextStyle(fontSize: 20, fontFamily: 'Trueno'),
                //       ),
                //       onPressed:  onLogoutPress
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
