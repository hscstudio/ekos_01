// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ekos_01/models/auth.dart';
import 'package:ekos_01/models/catalog.dart';
import 'package:ekos_01/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekos_01/models/cart.dart';
import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

class MyCatalog extends StatefulWidget {
  @override
  _MyCatalogState createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = CatalogModel().loadData();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthModel>(context, listen: false);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverFillRemaining(
            child: FutureBuilder<List<ProductModel>>(
              future: futureProducts,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return new Container(
                    child: Center(child: new CircularProgressIndicator()),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext content, int index) {
                        return _MyListItem(snapshot.data[index]);
                      },
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            auth.isGuest
                ? Container()
                : UserAccountsDrawerHeader(
                    accountName: Text(auth.user.name),
                    accountEmail: Text(auth.user.username),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(auth.user.avatar),
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                    ),
                  ),
            Card(
              elevation: 0,
              child: ListTile(
                title: Text('Profile'),
                leading: const Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                title: Text('Logout'),
                leading: const Icon(Icons.power_settings_new),
                onTap: () {
                  auth.logout();
                  Navigator.pushReplacementNamed(context, '/');
                  // Then close the drawer
                  // Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Katalog Produk',
        style: TextStyle(
          fontSize: 22.0,
          color: Colors.white,
        ),
      ),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final ProductModel product;

  _MyListItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>((cart) =>
        cart.items.indexWhere((element) => element.id == this.product.id) >= 0);
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.avatar),
        ),
        trailing: isInCart
            ? Icon(Icons.check, semanticLabel: 'ADDED')
            : Text('Pilih'),
        title: Text(product.name),
        subtitle: Text(formatCurrency.format(double.parse(product.price)),
            style: TextStyle(
              fontStyle: FontStyle.italic,
            )),
        onTap: () {
          var cart = context.read<CartModel>();
          cart.add(this.product);
        },
      ),
    );
  }
}
