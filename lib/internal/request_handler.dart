import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart';
import 'package:crypto/crypto.dart';

class RequestHandler {
  String _APIKEY = "";

  RequestHandler(String api) {
    _APIKEY = api;
  }
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<String> getServerIds(String key) async {
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": key,
    });
    //print("Response from register response: " + response.body);

    return response.body;
  }

  Future<String> getAssignId(String key) async {
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": key,
    });
    print("getAssignID: " + response.body);

    return response.body;
  }

  Future<dynamic> newAssignment(
    String id,
    String title,
    String chapters,
    String studentSchool,
    String gradeLevel,
    String subject,
    String description,
    String userId,
    String assignNumber,
    String status,
    String checkerNotes,
    String checkerUserId,
    String created_at,
    String updated_at,
  ) async {
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": _APIKEY,
      "id": id,
      "title": title,
      "chapters": chapters,
      "studentSchool": studentSchool,
      "gradeLevel": gradeLevel,
      "subject": subject,
      "description": description,
      "userId": userId,
      "assignNumber": assignNumber,
      "status": status,
      "checkerNotes": checkerNotes,
      "checkerUserId": checkerUserId,
      "created_at": created_at,
      "updated_at": updated_at,
    });

    print("Response from add assignment request: " + response.body);

    return response.body.toString();
  }

  Future<String> confirmAccount(String email, String password) async {
    print(_APIKEY + "  " + email + "  " + password);
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": _APIKEY,
      "email": email,
      "password": generateMd5(password),
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

  Future<String> registerAccount(
      String nextId,
      String email,
      String password,
      String mobile,
      String status,
      String freeAssignment,
      String userType,
      String gradeLevel) async {
    print("Next ID: " + nextId);
    Response response =
        await post(Uri.parse("https://edcheck.app/api/test.php"), body: {
      "key": _APIKEY,
      "id": nextId,
      "email": email,
      "password": generateMd5(password),
      "status": status,
      "freeAssignments": freeAssignment,
      "userType": userType,
      "gradeLevel": gradeLevel
    });

    print("Response from query register: " + response.body);

    return response.body.toString();
  }
}
