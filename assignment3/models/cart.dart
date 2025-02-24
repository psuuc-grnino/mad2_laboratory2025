import 'package:flutter/material.dart';
import 'package:nino_assignment3/models/products.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> get items => _cart;

  // var totalQty = 0;

  int get count {
    return _cart.length;
  }

  int get countTotal {
    int sum = 0;
    _cart.forEach((item) => sum += item.qty);
    return sum;
  }

  void add(CartItem item) {
    _cart.add(item);
    notifyListeners();
    // totalQty += item.qty;
  }
}

class CartItem {
  final Product product;
  final int qty;

  CartItem({required this.product, this.qty = 1});
}
