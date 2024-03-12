import 'dart:convert';

import 'package:dio_api_calling/api_service.dart';
import 'package:dio_api_calling/model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Example',
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _productService.getProducts();
    setState(() {
      _products = products;
    });
  }

  Future<void> _deleteProduct(int id) async {
    await _productService.deleteProduct(id);
    setState(() {
      _products.removeWhere((product) => product.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          Product product = _products[index];
          return ListTile(
            title: Text(product.title ?? ''),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteProduct(product.id ?? 0);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Implement adding a new product
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
