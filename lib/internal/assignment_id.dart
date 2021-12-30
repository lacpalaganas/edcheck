class AssignmentId {
  String id;
  String assignNumber;

  factory AssignmentId.fromJson(dynamic json) => AssignmentId(
        id: json["id"],
        assignNumber: json["assignNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignNumber": assignNumber,
      };

  AssignmentId({required this.id, required this.assignNumber});

  @override
  String toString() {
    return '{ ${this.id}, ${this.assignNumber}, }';
  }
}
