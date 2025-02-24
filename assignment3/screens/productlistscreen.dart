import 'package:flutter/material.dart';
import 'package:nino_assignment3/models/cart.dart';
import 'package:nino_assignment3/screens/product_details.dart';
import 'package:provider/provider.dart';
import 'package:nino_assignment3/models/products.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var products = Provider.of<Products>(context, listen: true); // ui update
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("View Products", style: TextStyle(color: Colors.white)),
        actions: [
          Consumer<Cart>(
            builder: (context, cart, _) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${cart.countTotal > 99 ? '99+' : cart.countTotal}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () => showAddDialog(context),
            icon: Icon(Icons.add),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Consumer<Products>(
        builder: (context, products, _) {
          return ListView.builder(
            itemBuilder: (_, index) {
              var prod = products.items[index];
              return Card(
                child: ListTile(
                  title: Text(prod.name),
                  leading: Icon(
                    prod.isFav ? Icons.favorite : Icons.favorite_outline,
                  ),
                  trailing: IconButton(
                    onPressed: () => addToCart(context, prod),
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(index: index),
                        ),
                      ),
                ),
              );
            },
            itemCount: products.count,
          );
        },
      ),
    );
  }

  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () => doAdd(context),
              child: const Text('Add'),
            ),
          ],
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  label: Text("Product Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: descCtrl,
                decoration: InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: priceCtrl,
                decoration: InputDecoration(
                  label: Text("Price"),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void doAdd(BuildContext context) {
    var product = Product(
      code: 0,
      name: nameCtrl.text,
      desc: descCtrl.text,
      price: double.parse(priceCtrl.text),
    );
    var provider = Provider.of<Products>(context, listen: false);
    provider.add(product);
    Navigator.of(context).pop();
  }

  void addToCart(BuildContext context, Product product) {
    Provider.of<Cart>(context, listen: false).add(CartItem(product: product));
  }

  void doDelete(BuildContext context, Product product) {}
}
