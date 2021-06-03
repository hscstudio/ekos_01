// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekos_01/common/theme.dart';
import 'package:ekos_01/models/cart.dart';
import 'package:ekos_01/models/catalog.dart';
import 'package:ekos_01/screens/cart.dart';
import 'package:ekos_01/screens/catalog.dart';
import 'package:ekos_01/screens/login.dart';

import 'models/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
