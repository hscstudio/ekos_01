// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ekos_01/models/response.dart';
import 'package:ekos_01/models/user.dart';
import 'package:ekos_01/services/auth.dart';
import 'package:flutter/material.dart';

final AuthService _service = AuthService();

class AuthModel extends ChangeNotifier {
  late ResponseModel _responseModel;
  late dynamic _user;
  late bool _isGuest = true;

  Future<ResponseModel> login(String username, String password) async {
    _responseModel = await _service.login(username, password);
    if (_responseModel.status == 'success') {
      _user = _responseModel.data;
      _isGuest = false;
    } else {
      _user = null;
      _isGuest = true;
    }
    notifyListeners();
    return _responseModel;
  }

  UserModel get user => _user;
  bool get isGuest => _isGuest;

  void logout() {
    _user = null;
    _isGuest = true;
    notifyListeners();
  }
}
