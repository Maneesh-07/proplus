import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proplus/model/product_add_model.dart';
import 'package:http/http.dart' as http;

class ProductAddProvider with ChangeNotifier {
  List<Product> products = [];

  Future<void> uploadImageAndCreateProduct({
    required TextEditingController codeController,
    required TextEditingController nameController,
    required TextEditingController priceController,
    required TextEditingController descriptionController,
    required selectedImage,
  }) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      // Handle error, user canceled image selection
      return;
    }

    final product = Product(
      code: codeController.text,
      name: nameController.text,
      price: double.parse(priceController.text),
      description: descriptionController.text,
    );

    final response = await createProductWithImage(product, pickedFile);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // For example, products.add(product);
      final responseData = json.decode(response.body);
      print('Product created successfully. Response: $responseData');
      // You can also display a success message to the user
      notifyListeners();
    } else {
      // Handle errors, e.g., show an error message
      print('Failed to create product. Status code: ${response.statusCode}');
    }
  }

  Future<http.Response> createProductWithImage(
      Product product, XFile imageFile) async {
    final request = http.MultipartRequest('POST',
        Uri.parse('https://spotit.cloud/interview/api/products/create'));

    // Add image to the request
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      await imageFile.readAsBytes(),
      filename: 'product_image.jpg',
    ));

    // Add product data to the request
    request.fields.addAll(product.toJson());

    // Send the request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    // Check for redirection
    if (response.statusCode == 302 ||
        response.statusCode == 200 ||
        response.statusCode == 201) {
      final newLocation = response.headers['location'];
      // Follow the redirection by sending a new GET request to the new location
      final redirectResponse = await http.get(Uri.parse(newLocation!));
      return redirectResponse;
    } else {
      return response;
    }
  }
}
