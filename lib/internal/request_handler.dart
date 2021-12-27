import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';

class RequestHandler {
  String _APIKEY = "";

  RequestHandler(String api) {
    _APIKEY = api;
  }

  Future<String> confirmAccount(String email, String password) async {
    print(_APIKEY + "  " + email + "  " + password);
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": _APIKEY,
      "email": email,
      "password": password,
    });
    print("Response from login: " + response.body);

    return response.body;
  }

  Future<String> sendQuery(String email, String id) async {
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": _APIKEY,
      "email": email,
      "id": id,
    });

    print("Response from query: " + response.body);
    return response.body;
  }
}
