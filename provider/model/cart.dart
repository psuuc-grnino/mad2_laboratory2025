import 'package:flutter/material.dart';
import 'package:provider_laboratory/model/product.dart';

class Carts extends ChangeNotifier {
  final List<Cart> _carts = [];

  List<Cart> get itemCarts => _carts;

  int get count {
    return _carts.length;
  }

  int get countTotal {
    int c = 0;
    _carts.forEach((item) => c += item.count);
    return c;
  }
  void add(Cart item){
    _carts.add(item);
    notifyListeners();
  }
}

class Cart {
  final Products products;
  late int count;

  Cart({
    required this.products,
    this.count = 1,
  });
}
