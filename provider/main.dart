import 'package:flutter/material.dart';
import 'package:provider_laboratory/model/cart.dart';
import 'package:provider_laboratory/model/product.dart';
import 'package:provider_laboratory/screens/list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Product()),
        ChangeNotifierProvider(create: (context) => Carts()),
      ],
      child: MaterialApp(
      home: ListScreen(),
      debugShowCheckedModeBanner: false,
      ),
    );
  }
}
