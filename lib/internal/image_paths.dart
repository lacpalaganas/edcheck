class ImagePaths {
  String name;
  String imagePath;
  String assignNumber;

  factory ImagePaths.fromJson(dynamic json) => ImagePaths(
        name: json["name"],
        imagePath: json["imagePath"],
        assignNumber: json["assignNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imagePath": imagePath,
        "assignNumber": assignNumber,
      };

  ImagePaths(
      {required this.name,
      required this.imagePath,
      required this.assignNumber});

  @override
  String toString() {
    return '{ ${this.name}, ${this.imagePath}, ${this.assignNumber}), }';
  }
}
