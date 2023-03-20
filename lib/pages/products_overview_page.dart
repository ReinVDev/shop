import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/utils/app_routes.dart';
import '../components/new_badge.dart';
import '../components/product_grid.dart';
import '../models/cart.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showOnlyFavorite = false;
  void toCart() {
    Navigator.of(context).pushNamed(AppRoutes.cartInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          Consumer<Cart>(
              child: IconButton(
                  onPressed: () => toCart(),
                  icon: const Icon(Icons.shopping_cart)),
              builder: (ctx, cart, child) => NewBadge(
                    value: cart.itemsCount.toString(),
                    child: child!,
                  )),
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (cart) => [
                    const PopupMenuItem(
                      value: FilterOptions.favorite,
                      child: Text('Somente Favoritos'),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.all,
                      child: Text('Todos'),
                    ),
                  ],
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorite) {
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              }),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(
          showOnlyFavorite: _showOnlyFavorite,
        ),
      ),
    );
  }
}
