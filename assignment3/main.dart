import 'package:flutter/material.dart';
import 'package:nino_assignment3/models/cart.dart';
import 'package:nino_assignment3/models/products.dart';
import 'package:nino_assignment3/screens/productlistscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(home: ProductListScreen()),
    );
  }
}
