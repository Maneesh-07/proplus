import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proplus/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<ProductModel> productList = jsonData.map((item) {
        return ProductModel.fromJson(item);
      }).toList();

      _products = productList;
      notifyListeners();

      return productList; // Return the list of products
    } else {
      throw Exception('Failed to load products');
    }
  }
}
