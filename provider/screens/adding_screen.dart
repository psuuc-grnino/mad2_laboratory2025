import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider_laboratory/model/product.dart';
import 'package:provider_laboratory/screens/list_screen.dart';
import 'package:provider/provider.dart';

class AddingScreen extends StatelessWidget {
  const AddingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: idCtrl,
              decoration: InputDecoration(
                hintText: 'Id',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Gap(5),
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Gap(5),
            TextField(
              controller: descCtrl,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Gap(5),
            ElevatedButton(
              onPressed: () => addProd(context),
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void addProd(BuildContext context) {
    var prod = Products(
      id: int.parse(idCtrl.text),
      name: nameCtrl.text,
      desc: descCtrl.text,
    );
    var products = Provider.of<Product>(context, listen: false);
    products.add(prod);
    Navigator.of(context).pop();
  }
}
