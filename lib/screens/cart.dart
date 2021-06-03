// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ekos_01/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ekos_01/models/cart.dart';
import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang Belanja',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _CartList(),
              ),
              Divider(color: Colors.grey),
              _CartTotal(),
              SizedBox(
                height: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    var cart = context.watch<CartModel>();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: cart.items.length,
      itemBuilder: (BuildContext content, int index) {
        return _MyListItem(cart.items[index]);
      },
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    var cart = context.watch<CartModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text('Total')),
        Text(
          formatCurrency.format(cart.totalPrice()),
          style: TextStyle(fontSize: 22),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Checkout not supported yet.')));
          },
          style: TextButton.styleFrom(primary: Colors.white),
          child: Text('Checkout'),
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
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.avatar),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            var cart = context.read<CartModel>();
            cart.remove(this.product);
          },
        ),
        title: Text(product.name),
        subtitle: Text(
          formatCurrency.format(double.parse(product.price)),
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
