class SampleRes {
  SampleRes({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
  });

  int id;
  String name;
  String username;
  String email;
  String phone;

  factory SampleRes.fromJson(Map<String, dynamic> json) => SampleRes(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
      };
}
