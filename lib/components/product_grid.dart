import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';
import 'package:shop/models/product_list.dart';

import '../models/product.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.showOnlyFavorite});
  final bool showOnlyFavorite;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showOnlyFavorite ? provider.favoriteItems : provider.items;
    return GridView.builder(
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
              value: loadedProducts[index], child: const ProductGridItem());
        });
  }
}
