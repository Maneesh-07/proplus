import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proplus/controller/add_product_provider.dart';
import 'package:proplus/views/ProductAdding/widgets/customtextfield.dart';
import 'package:proplus/views/home/widgets/appbar.dart';
import 'package:provider/provider.dart';

class ProductAddingScreen extends StatefulWidget {
  const ProductAddingScreen({Key? key}) : super(key: key);

  @override
  State<ProductAddingScreen> createState() => _ProductAddingScreenState();
}

class _ProductAddingScreenState extends State<ProductAddingScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  XFile? selectedImage; // Store the selected image file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomAppBar(title: 'Post Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  CustomTextFormWidget(
                    controller: codeController,
                    labelText: '45415',
                    productName: 'Product code',
                  ),
                  CustomTextFormWidget(
                    controller: nameController,
                    labelText: 'Enter your Product Name',
                    productName: 'Product name *',
                  ),
                  CustomTextFormWidget(
                    controller: priceController,
                    labelText: 'Enter your Product Price',
                    productName: 'Product price *',
                  ),
                  CustomTextFormWidget(
                    controller: descriptionController,
                    labelText: 'Add your description',
                    productName: 'Description *',
                  ),
                  // Display the selected image
                  if (selectedImage != null)
                    Image.file(
                      File(selectedImage!.path),
                      height: 100,
                      width: 100,
                    ),
                  const SizedBox(height: 10),

                  // Button to select another image
                  ElevatedButton(
                    onPressed: () async {
                      final imagePicker = ImagePicker();
                      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          selectedImage = pickedFile;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Select Another Image'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  final productProvider = Provider.of<ProductAddProvider>(context, listen: false);
                  productProvider.uploadImageAndCreateProduct(
                    codeController: codeController,
                    nameController: nameController,
                    priceController: priceController,
                    descriptionController: descriptionController,
                    selectedImage: selectedImage,
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 60),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}