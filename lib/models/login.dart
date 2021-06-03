class LoginModel {
  late String _username = '';
  late String _password = '';

  String get username => _username;
  String get password => _password;

  void setUsername(value) {
    _username = value;
  }

  void setPassword(value) {
    _password = value;
  }

  LoginModel({required username, required password});
}
