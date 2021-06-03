// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ekos_01/models/product.dart';
import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  final List<ProductModel> _items = [];
  List<ProductModel> get items => _items.toList();

  void add(ProductModel item) {
    // https://coflutter.com/dart-how-to-find-an-item-in-a-list/
    final index = _items.indexWhere((element) => element.id == item.id);
    if (index == -1) {
      _items.add(item);
      notifyListeners();
    }
  }

  void remove(ProductModel item) {
    final index = _items.indexWhere((element) => element.id == item.id);
    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  double totalPrice() => _items.fold(
      0,
      (previous, ProductModel current) =>
          previous + double.parse(current.price));
}
