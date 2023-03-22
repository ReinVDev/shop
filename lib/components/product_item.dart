import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final removeProvider = Provider.of<ProductList>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.productForm, arguments: product);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text(
                            'Excluir Produto',
                          ),
                          content: const Text(
                            'Tem certeza?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                removeProvider.removeProduct(product);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Excluir',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Retornar'),
                            )
                          ],
                        ));
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
