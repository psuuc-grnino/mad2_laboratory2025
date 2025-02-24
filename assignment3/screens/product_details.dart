import 'package:flutter/material.dart';
import 'package:nino_assignment3/models/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder:
          (context, products, _) => Scaffold(
            appBar: AppBar(
              title: Text(products.items[index].name),
              actions: [
                IconButton(
                  onPressed: () {
                    Provider.of<Products>(
                      context,
                      listen: false,
                    ).toggleFavorite(products.items[index]);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    products.items[index].isFav
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Text(products.items[index].desc),
                Text(products.items[index].toString()),
              ],
            ),
          ),
    );
  }
}
