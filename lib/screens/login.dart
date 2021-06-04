// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ekos_01/models/auth.dart';
import 'package:ekos_01/models/user.dart';
import 'package:provider/provider.dart';
import 'package:ekos_01/models/response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var formData = {
    'username': 'Felicia.Lebsack@hotmail.com',
    'password': '99084'
  };
  bool _loading = false;

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Information'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _saveForm() async {
    setState(() => _loading = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String username = formData['username'].toString();
      String password = formData['password'].toString();
      var auth = Provider.of<AuthModel>(context, listen: false);
      ResponseModel response = await auth.login(username, password);
      setState(() => _loading = false);
      if (response.status == "success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        UserModel user = response.data;
        prefs.setString('id', user.id);
        prefs.setString('username', user.username);
        prefs.setString('password', user.password);
        prefs.setString('name', user.name);
        prefs.setString('avatar', user.avatar);
        Navigator.pushReplacementNamed(context, '/catalog');
      } else {
        _showDialog(response.message);
      }
    }
  }

  Future<void> _checkUserState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id') ?? '';
    var username = prefs.getString('username') ?? '';
    var password = prefs.getString('password') ?? '';
    var name = prefs.getString('name') ?? '';
    var avatar = prefs.getString('avatar') ?? '';
    var user = id != ''
        ? UserModel(
            id: id,
            name: name,
            username: username,
            password: password,
            avatar: avatar,
          )
        : null;
    if (user != null) {
      var auth = context.read<AuthModel>();
      auth.autoLogin(user);
      Navigator.pushReplacementNamed(context, '/catalog');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUserState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/flutter-logo.png')),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Silakan login',
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextFormField(
              initialValue: formData['username'],
              decoration: InputDecoration(hintText: 'Username'),
              validator: (value) {
                if (value!.isEmpty)
                  return 'You have to insert a username';
                else
                  formData['username'] = value;
                return null;
              },
            ),
            TextFormField(
              initialValue: formData['password'],
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              validator: (value) {
                if (value!.length < 5)
                  return 'Password must have at least 5 chars.';
                else
                  formData['password'] = value;
                return null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            _loading ? Center(child: CircularProgressIndicator()) : Text(''),
            ElevatedButton(
              child: Text(_loading ? 'Loading...' : 'Login'),
              onPressed: _loading
                  ? null
                  : () {
                      _saveForm();
                    },
            )
          ],
        ),
      ),
    );
  }
}
