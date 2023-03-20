import 'package:flutter/material.dart';

import '../models/product.dart';
import '../providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          const Text('Count', textAlign: TextAlign.center),
          IconButton(
              onPressed: () {
                setState(() {
                  CounterProvider.of(context)?.state.inc();
                });
              },
              icon: const Icon(Icons.add)),
          Text(CounterProvider.of(context)!.state.value.toString()),
        ],
      ),
    );
  }
}
