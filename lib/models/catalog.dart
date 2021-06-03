// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:ekos_01/models/product.dart';
import 'package:ekos_01/services/product.dart';
import 'package:flutter/material.dart';

final ProductService _service = ProductService();

class CatalogModel extends ChangeNotifier {
  late List<ProductModel> _products = [];

  Future<List<ProductModel>> loadData() async {
    _products = await _service.fetchProducts();
    notifyListeners();
    return _products;
  }

  List<ProductModel> get products => _products;

  ProductModel getById(int id) {
    List<ProductModel> products = _products
        .where(
            (ProductModel product) => (product.id.toString() == id.toString()))
        .toList();
    return products[0];
  }
}
