class SampleReq {
  SampleReq({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  int id;
  String name;
  String username;
  String email;

  factory SampleReq.fromJson(Map<String, dynamic> json) => SampleReq(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
      };
}
