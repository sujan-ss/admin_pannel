class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String number;
  final String password;
  final String imageUrl;
  final String passportImageUrl;
  final bool verified;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.number,
    required this.password,
    required this.imageUrl,
    required this.passportImageUrl,
    required this.verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      number: json['number'],
      password: json['password'],
      imageUrl: json['imageUrl'],
      passportImageUrl: json['passportImageUrl'],
      verified: json['verified'],
    );
  }
}
