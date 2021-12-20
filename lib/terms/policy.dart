import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Policy extends StatelessWidget {
  final String path;

  const Policy({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black), //change your color here
        title: Image.asset(
          'assets/images/edcheckLogo.png',
          width: 60.0,
          height: 60.0,
          fit: BoxFit.contain,

        ),

        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:
      FutureBuilder(
          future: rootBundle.loadString(path),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
