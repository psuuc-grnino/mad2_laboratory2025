import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  final List<Products> _product =[
  ];

  List<Products> get items => _product;

  int get count {
    return _product.length;
  }

  void add(Products p) {
    _product.add(p);
    notifyListeners();
  }

  void toggle(Products prod) {
    prod.isFavorite = !prod.isFavorite;
    notifyListeners();
  }
}

class Products {
  final int id;
  final String name;
  final String desc;
  bool isFavorite = false;

  Products(
      {required this.id,
      required this.name,
      required this.desc,
      this.isFavorite = false});
}
