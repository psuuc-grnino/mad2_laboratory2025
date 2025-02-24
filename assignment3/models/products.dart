import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

part 'products.realm.dart';

class Products extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get items => _products;

  int get count {
    return _products.length;
  }

  void add(Product p) {
    _products.add(p);
    notifyListeners();
  }

  void toggleFavorite(Product p) {
    p.isFav = !p.isFav;
    notifyListeners();
  }
}

@RealmModel()
class Product {
  late int code;
  late String name;
  late String desc;
  late double price;
  late bool isFav;

  Product({
    required this.code,
    required this.name,
    required this.desc,
    required this.price,
    this.isFav = false,
  });
}
