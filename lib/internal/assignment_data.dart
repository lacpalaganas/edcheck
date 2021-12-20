class AssignmentData {
  String title;
  String subject;
  String description;
  String status;
  String assignNumber;

  factory AssignmentData.fromJson(dynamic json) => AssignmentData(
        title: json["title"],
        subject: json["subject"],
        description: json["description"],
        status: json["status"],
        assignNumber: json["assignNumber"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subject": subject,
        "description": description,
        "status": status,
        "assignNumber": assignNumber,
      };

  AssignmentData(
      {required this.title,
      required this.subject,
      required this.description,
      required this.status,
      required this.assignNumber});

  @override
  String toString() {
    return '{ ${this.title}, ${this.subject},${this.description}, ${this.status}, ${this.assignNumber}), }';
  }
}
