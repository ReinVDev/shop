import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product_list.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gerenciar Produtos"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.productForm),
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: products.itemsCount,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    ProductItem(product: products.items[i]),
                    const Divider(),
                  ],
                );
              }),
        ));
  }
}
