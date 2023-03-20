import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
              title: Text(
                product.name,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black87,
              leading: Consumer<Product>(
                builder: (cxt, product, _) => IconButton(
                  onPressed: () => product.toggleFavorite(),
                  icon: product.isFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  cart.addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Produto adicionado!',
                      textAlign: TextAlign.left,
                    ),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                        label: 'DESFAZER',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ));
                },
                icon: const Icon(Icons.shopping_cart),
                color: Theme.of(context).colorScheme.secondary,
              )),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.productDetail, arguments: product);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
