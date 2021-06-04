// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:camera/camera.dart';
import 'package:ekos_01/models/user.dart';
import 'package:ekos_01/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekos_01/common/theme.dart';
import 'package:ekos_01/models/cart.dart';
import 'package:ekos_01/models/catalog.dart';
import 'package:ekos_01/screens/cart.dart';
import 'package:ekos_01/screens/catalog.dart';
import 'package:ekos_01/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/auth.dart';

// void main() {
//   runApp(MyApp());
// }

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  runApp(MyApp(cameras));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late String initialRoute = '/';
  final cameras;

  MyApp(this.cameras, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CatalogModel>(
            create: (context) => CatalogModel()),
        ChangeNotifierProvider<CartModel>(create: (context) => CartModel()),
        ChangeNotifierProvider<AuthModel>(create: (context) => AuthModel()),
      ],
      child: MaterialApp(
        title: 'Ekos 01 Demo',
        theme: appTheme,
        initialRoute: initialRoute,
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
          '/profile': (context) => MyProfile(),
        },
      ),
    );
  }
}
