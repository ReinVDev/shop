import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageFocus.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['image'] = product.imageUrl;

        _imageController.text = product.imageUrl;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _imageFocus.addListener((updateImage));
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWith = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWith;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      _formKey.currentState?.save();
      Navigator.of(context).pop();
      Provider.of<ProductList>(context, listen: false)
          .saveProductFromData(_formData);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Formulário do Produto'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                onSaved: (name) => _formData['name'] = name ?? ' ',
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                validator: (newName) {
                  final name = newName ?? '';
                  if (name.trim().isEmpty) {
                    return 'Nome inválido!';
                  }
                  if (name.trim().length < 2) {
                    return 'Nome invalido! (Mínimo de 2 caracteres!';
                  }
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                focusNode: _priceFocus,
                validator: (newPrice) {
                  final price = double.parse(newPrice ?? '0');
                  if (price <= 0) {
                    return 'Preço inválido!';
                  }
                },
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                onSaved: (description) =>
                    _formData['description'] = description ?? ' ',
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageFocus);
                },
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocus,
                validator: (newDescription) {
                  final description = newDescription ?? '';
                  if (description.trim().isEmpty) {
                    return 'Descrição inválida!';
                  }
                  if (description.trim().length < 10) {
                    return 'Mínimo de 10 caracteres';
                  }
                },
                textInputAction: TextInputAction.next,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      onFieldSubmitted: (_) => _submitForm(),
                      focusNode: _imageFocus,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      validator: (newImageUrl) {
                        final imageUrl = newImageUrl ?? '';
                        if (!isValidImageUrl(imageUrl)) {
                          return 'URL inválida.';
                        }
                      },
                      onSaved: (imageUrl) =>
                          _formData['image'] = imageUrl ?? '',
                      controller: _imageController,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageController.text.isEmpty
                        ? const Text('Informe a URL')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageController.text),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
