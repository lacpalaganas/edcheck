import 'dart:async';
import 'dart:convert';

import 'package:edcheck/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TestAPI extends StatefulWidget {
  const TestAPI({Key? key}) : super(key: key);

  @override
  _TestAPIState createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  String name = "";
  String attributes = "";
  String randomVariable = "";
  String _error = 'No Error Dectected';
  Timer? timer;
  //getSampleData
  // void getData() async {
  //   Response response = await get(
  //     Uri.parse('https://edcheck.app/api/test.php'),
  //   );

  //   print(response.body);
  // }

  void getDataWithKey() async {
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": "0328fjkasdocaksdut209029350293jrlMFLSAJDFPAOUW09IRW",
      "testVariable": "1",
    });

    print(response.body);
  }

  @override
  void initState() {
    // timer = Timer.periodic(Duration(seconds: 50), (Timer t) => postData());
    // tz.initializeTimeZones();

    // getDataWithKey();
  }

  @override
  void dispose() {
    // timer?.cancel();

    super.dispose();
  }

  // Future<void> postData() async {
  //   String error = 'No Error Detected';
  //   Response response =
  //       await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
  //     "key": "0328fjkasdocaksdut209029350293jrlMFLSAJDFPAOUW09IRW",
  //     "testVariable": "1",
  //   });

  //   Map data = json.decode(response.body);
  //   if (this.mounted) {
  //     setState(() {
  //       name = data["name"];
  //       attributes = data["attributes"];
  //       randomVariable = data["randomVariable"].toString();
  //       _error = attributes;
  //     });
  //   }

  //   NotificationService()
  //       .showNotification(1, name, "random variable ${randomVariable}");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test API"),
        ),
        body: Center(
          child: Text("test"),
        ));
  }
}
