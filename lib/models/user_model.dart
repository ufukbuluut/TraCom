class UserModel {
  UserModel({
    required this.about,
    required this.email,
    required this.emailVerified,
    required this.interests,
    required this.knownLanguages,
    required this.phoneNumber,
    required this.type,
    required this.name,
    required this.photoUrl,
  });

  String name;
  String email;
  String photoUrl;
  String type;
  String about;
  String phoneNumber;
  List<String> knownLanguages;
  String interests;
  bool emailVerified;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        type: json["type"],
        about: json["about"],
        phoneNumber: json["phoneNumber"],
        knownLanguages: List<String>.from(json["knownLanguages"]),
        interests: json["interests"],
        emailVerified: json["emailVerified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "type": type,
        "about": about,
        "phoneNumber": phoneNumber,
        "knownLanguages": List<dynamic>.from(knownLanguages),
        "interests": interests,
        "emailVerified": emailVerified,
      };
}
