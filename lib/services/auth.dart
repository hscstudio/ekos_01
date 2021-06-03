import 'dart:async';
import 'dart:convert';

import 'package:ekos_01/models/response.dart';
import 'package:ekos_01/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<ResponseModel> login(String username, String password) async {
    String status = 'error';
    String message = 'terjadi kesalahan';
    dynamic data = {};

    final response = await http.get(Uri.parse(
        'https://60b7338a17d1dc0017b8947a.mockapi.io/api/v1/users/1'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      UserModel user = UserModel.fromJson(parsed);
      if (username == user.username) {
        if (password == user.password) {
          status = 'success';
          message = 'login berhasil';
          data = user;
        } else {
          status = 'warning';
          message = 'password salah';
        }
      } else {
        status = 'warning';
        message = 'username salah';
      }
      // print(username + ' = ' + parsed);
      return ResponseModel(status: status, message: message, data: data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // throw Exception('Unable to fetch products from the REST API');
      return ResponseModel(
          status: status, message: 'koneksi ke server gagal', data: data);
    }
  }
}
