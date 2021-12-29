import 'package:edcheck/terms/policy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormChecker extends StatefulWidget {
  const RegisterFormChecker({Key? key}) : super(key: key);

  @override
  _RegisterFormCheckerState createState() => _RegisterFormCheckerState();
}

class _RegisterFormCheckerState extends State<RegisterFormChecker> {
  bool agreement = false;
  final nameControler = TextEditingController();
  final phoneNumberControler = TextEditingController();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  final confirmPasswordControler = TextEditingController();

  //added var
  bool isObscure = true;

  void onRegisterPress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Checker Registration'),
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 6.0, right: 6.0),
          child: Container(
            color: Colors.white,
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
                          child: TextField(
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
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: confirmPasswordControler,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE6E6E6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
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
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
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
                            textStyle: const TextStyle(
                                fontSize: 20, fontFamily: 'Trueno'),
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
        ));
  }
}
