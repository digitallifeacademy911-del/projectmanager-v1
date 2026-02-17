class User {
  String email;
  String id;
  User({required this.id, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], email: json['username']);
  }
}
