import 'package:flutter/material.dart';
import 'package:provider_laboratory/model/cart.dart';
import 'package:provider_laboratory/model/product.dart';
import 'package:provider_laboratory/screens/adding_screen.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

var idCtrl = TextEditingController();
var nameCtrl = TextEditingController();
var descCtrl = TextEditingController();

bool istoggle = false;

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<Carts>(
            builder: (context, cart, _) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddingScreen(),
              ));
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Consumer<Product>(
        builder: (context, product, _) {
          return ListView.builder(
            itemCount: product.count,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap:(){

                },
                child: Card(
                  child: ListTile(
                     leading: IconButton(
                      onPressed: () => product.toggle(product.items[index]),
                    icon: Icon(product.items[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border), 
                    ),
                    trailing: IconButton(
                        onPressed: ()=>addTocart, icon: Icon(Icons.shopping_bag),
                        
                        ),
                    title: Text(product.items[index].name),
                    subtitle: Text(product.items[index].name),
                   
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void addTocart(BuildContext context, Products products) {
    Provider.of<Carts>(
      context, listen: false).add(Cart(products: products));
  }
}
