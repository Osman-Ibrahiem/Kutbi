class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? token;

  UserModel({this.id, this.name, this.email, this.photoUrl, this.token});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'token': token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      token: json['token'],
    );
  }
}
