class UserModel {
  final String id;
  final String name;
  final String username;
  final String password;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      avatar: json['avatar'],
    );
  }
}
