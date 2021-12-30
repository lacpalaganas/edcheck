// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:edcheck/internal/account.dart';
import 'package:edcheck/internal/request_handler.dart';
import 'package:edcheck/internal/school.dart';

import 'package:edcheck/gui/homepage/register_form_checker.dart';

import 'package:edcheck/terms/policy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:crypto/crypto.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  bool agreement = false;
  TextEditingController nameControler = TextEditingController();
  TextEditingController phoneNumberControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController schoolControler = TextEditingController();
  //added var
  bool isObscure = true;

  final _formKey = GlobalKey<FormState>();

  final String _APIKEY = "e1eb74bc5148970392bd89e2d0822f29e27fc9c12";

  String userType = "1";

  void onRegisterPress() async {
    if (_formKey.currentState!.validate()) {
      setState(() {});

      String name = nameControler.text.trim();
      String mobile = phoneNumberControler.text.trim();
      String school = schoolControler.text.trim();
      String password = passwordControler.text.trim();

      String status = "1";
      String freeAssignment = "1000";
      String gradeLevel = "1";
      String userType = "1";

      var email = emailControler.text.trim();

      print("Name inputted: " + nameControler.text);
      print("Mobile inputted: " + phoneNumberControler.text);
      print("Email inputted: " + emailControler.text);
      print("Pass inputted: " + password);
      print("School inputted: " + schoolControler.text);

      RequestHandler request = RequestHandler(_APIKEY);
      var data = await request
          .getServerIds("e1eb74bc5148970392bd89e2d0822f29e27fc9c14");

      var jsonData = jsonDecode(data);
      List<Account> accounts = [];
      for (Map accs in jsonData) {
        int iterate = 0;
        accounts.insert(iterate, Account.fromJson(accs));
        //print("id: " + accounts[iterate].id);
        iterate++;
      }
      print("last digit = " + accounts[0].id);
      int lastId = int.parse(accounts[0].id.toString());
      int nextId = lastId + 1;

      if (await request.registerAccount(nextId.toString(), email, password,
              mobile, status, freeAssignment, userType, gradeLevel) ==
          "true") {
        ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(content: new Text('Registration successful')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(content: new Text('Registration successful')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text('Invalid Input')));
    }
  }

  void onLegalPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Policy(
                path: 'assets/policies/legal_disclaimer.md',
              )),
    );
  }

  void onTermsPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Policy(
                path: 'assets/policies/terms_conditions.md',
              )),
    );
  }

  void onPrivacyPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Policy(
                path: 'assets/policies/privacy_policy.md',
              )),
    );
  }

  void onCookiesPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Policy(
                path: 'assets/policies/cookie_policy.md',
              )),
    );
  }

  onAgreeChanged(bool? agreeCheckBox) {
    setState(() {
      agreement = agreeCheckBox ?? true;
      print("Check Box: " + onAgreeChanged.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: Container(
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
                          'Create an Account',
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
                    ),
                  ),
                  SizedBox(height: 4.0),
                  // Container(
                  //   padding: EdgeInsets.only(left: 14.0, right: 25.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       RichText(
                  //         text: TextSpan(
                  //           text: 'Register as ',
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 16.0,
                  //             fontFamily: 'Trueno',
                  //           ),
                  //           children: <TextSpan>[
                  //             TextSpan(
                  //                 text: 'Checker.',
                  //                 recognizer: TapGestureRecognizer()
                  //                   ..onTap = () {
                  //                     Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               RegisterFormChecker(),
                  //                         ));
                  //                   },
                  //                 style: TextStyle(
                  //                   color: Colors.green,
                  //                   fontSize: 16.0,
                  //                   fontFamily: 'Trueno',
                  //                 )),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                          labelText: 'Full name',
                          prefixIcon: Icon(Icons.assignment_ind),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: phoneNumberControler,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE6E6E6),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          labelText: 'Phone number',
                          prefixIcon: Icon(Icons.phone_iphone),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (value) {
                            String pattern =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            RegExp regex = RegExp(pattern);
                            if (value == null ||
                                value.isEmpty ||
                                !regex.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          controller: emailControler,
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
                      )),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: passwordControler,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE6E6E6),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TypeAheadFormField(
                        direction: AxisDirection.up,
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: schoolControler,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE6E6E6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            labelText: 'Schools',
                            prefixIcon: Icon(Icons.school_rounded),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return Schools.getSuggestions(pattern);
                        },
                        noItemsFoundBuilder: (context) => Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'No schools found.',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                        onSuggestionSelected: (suggestion) {
                          this.schoolControler.text = suggestion.toString();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: Icon(Icons.school_rounded),
                            title: Text(suggestion.toString()),
                          );
                        }),
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: agreement,
                        onChanged: (value) {
                          setState(() {
                            agreement = value ?? false;
                            print(agreement);
                          });
                        },
                      ),
                      Expanded(
                          child: RichText(
                        text: TextSpan(
                          text: 'I agree to the ',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Terms of Service, ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Policy(
                                                path:
                                                    'assets/policies/terms_conditions.md',
                                              )),
                                    );
                                  },
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15.0)),
                            TextSpan(
                                text: 'Cookie Policy, ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Policy(
                                                path:
                                                    'assets/policies/cookie_policy.md',
                                              )),
                                    );
                                  },
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15.0)),
                            TextSpan(
                                text: 'Legal Disclaimer, ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Policy(
                                                path:
                                                    'assets/policies/legal_disclaimer.md',
                                              )),
                                    );
                                  },
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15.0)),
                            TextSpan(
                                text: 'and Privacy Policy. ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Policy(
                                                path:
                                                    'assets/policies/privacy_policy.md',
                                              )),
                                    );
                                  },
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15.0)),
                            TextSpan(
                                text: 'Registrer as Checker. ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterFormChecker(),
                                        ));
                                  },
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15.0)),
                          ],
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400.0, 60),
                        primary: Colors.green,
                        textStyle:
                            const TextStyle(fontSize: 20, fontFamily: 'Trueno'),
                      ),
                      onPressed: agreement ? onRegisterPress : null,
                    ),
                  ),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
