import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';

import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newProduct = Product(
      description: data['description'] as String,
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      imageUrl: data['image'] as String,
      name: data['name'] as String,
      price: data['price'] as double,
    );
    if (hasId) {
      updateProduct(newProduct);
    } else {
      addProduct(newProduct);
    }
  }

  void removeProduct(Product product) {
    _items.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }
}
