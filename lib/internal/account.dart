class Account {
  String id;
  String email;
  String loginStatus;

  factory Account.fromJson(dynamic json) => Account(
        id: json["id"],
        email: json["email"],
        loginStatus: json["loginStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "loginSTatus": loginStatus,
      };

  Account({required this.id, required this.email, required this.loginStatus});

  @override
  String toString() {
    return '{ ${this.id}, ${this.email}, ${this.loginStatus}), }';
  }
}
