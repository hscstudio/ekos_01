// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ekos_01/models/auth.dart';
import 'package:provider/provider.dart';
import 'package:ekos_01/models/response.dart';
import 'package:flutter/material.dart';

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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String username = formData['username'].toString();
      String password = formData['password'].toString();
      var auth = Provider.of<AuthModel>(context, listen: false);
      ResponseModel response = await auth.login(username, password);
      if (response.status == "success") {
        Navigator.pushReplacementNamed(context, '/catalog');
      } else {
        _showDialog(response.message);
      }
    }
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
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                _saveForm();
              },
            )
          ],
        ),
      ),
    );
  }
}
