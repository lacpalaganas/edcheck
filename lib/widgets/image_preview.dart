import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;
  const ImagePreview({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Container(
            child: PhotoView(
          imageProvider: NetworkImage(imagePath),
        )));
  }
}
