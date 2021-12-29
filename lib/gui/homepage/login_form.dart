// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:edcheck/internal/account.dart';
import 'package:edcheck/internal/request_handler.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  final Function(String) callback;
  LoginForm(this.callback);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool rememberMe = false;
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  final recoverEmailControler = TextEditingController();
  final recoverPasswordControler = TextEditingController();

  final APIKEY = "e1eb74bc5148970392bd89e2d0822f29e27fc9c1";

  //added var
  bool isObscure = true;

  void onRememberMeChanged(bool? rememberMeCheckBox) {
    setState(() {
      rememberMe = rememberMeCheckBox ?? true;
      print("Check Box: " + rememberMe.toString());
    });
  }

  onLoginPress() async {
    print('login pressed');

    var networkHandler = RequestHandler(APIKEY);
    String data = await networkHandler.confirmAccount(
        emailControler.text, passwordControler.text);
    if (data != "0") {
      var jsonData = jsonDecode(data);
      dynamic acc = jsonData;
      Account acc2 = Account.fromJson(acc[0]);

      print("there is" + acc2.id.toString());
      if (acc2.loginStatus.toString() == "1") {
        ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: new Text('Login successful')));

        final prefs = await SharedPreferences.getInstance();

        prefs.setBool('loggedIn', rememberMe);
        prefs.setString('id', acc2.id.toString());
        prefs.setString('email', acc2.email.toString());
        print("Remember is checked: " + rememberMe.toString());
        var newNetwork = RequestHandler(
            "0328fjkasdocaksdut209029350293jrlMFLSAJDFPAOUW09IRW");
        newNetwork.sendQuery(acc2.email.toString(), acc2.id.toString());

        widget.callback("student");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: new Text('Login Failed!')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text('Login Failed!')));
    }
  }

  void onRecoverPress() {
    gendialog();
  }

  void onSubmitPress() {
    print('submit pressed');
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
                          'Hello There',
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
                      //  cursorColor: Colors.black,

                      controller: emailControler,
                      decoration: InputDecoration(
                        // focusedBorder:OutlineInputBorder(
                        //   borderSide: const BorderSide(color: Colors.green, width: 2.0),
                        //   borderRadius: BorderRadius.circular(6.0),
                        //
                        // ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE6E6E6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        labelText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordControler,
                    obscureText: isObscure,
                    decoration: InputDecoration(
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(value: rememberMe, onChanged: onRememberMeChanged),
                    Text("Remember me")
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  // child: TextButton(
                  //
                  //   style: ButtonStyle(
                  //
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.white),
                  //     backgroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.black),
                  //   ),
                  //   onPressed: onLoginPress,
                  //   child: Text('Log in'),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(400.0, 60),
                      primary: Colors.green,
                      textStyle:
                          const TextStyle(fontSize: 20, fontFamily: 'Trueno'),
                    ),
                    onPressed: onLoginPress,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Forgot username or password?',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: onRecoverPress,
                    child: Text(
                      'Recover',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void gendialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0)), //this right here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Divider(color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Input your email address. If you have an account with us, '
                          'you will receive a password reset link.',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16.0),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: recoverEmailControler,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE6E6E6),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              labelText: 'Email Address',
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: recoverPasswordControler,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE6E6E6),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              labelText: 'Password',
                            ),
                          )),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: TextButton(
                      //     style: ButtonStyle(
                      //       foregroundColor:
                      //           MaterialStateProperty.all<Color>(Colors.white),
                      //       backgroundColor:
                      //           MaterialStateProperty.all<Color>(Colors.black),
                      //     ),
                      //     onPressed: onSubmitPress,
                      //     child: Text('Submit'),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(400.0, 50.0),
                            primary: Colors.green,
                            textStyle: const TextStyle(
                                fontSize: 20, fontFamily: 'Trueno'),
                          ),
                          onPressed: onSubmitPress,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
