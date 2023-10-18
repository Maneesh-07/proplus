import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proplus/controller/product_provider.dart';
import 'package:proplus/model/product_model.dart';
import 'package:proplus/views/home/product_detail_page.dart';
import 'package:proplus/views/home/widgets/appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    List<ProductModel> data = await productProvider.fetchProducts();
    setState(() {
      products = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomAppBar(title: 'Product details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: (value) {},
              onSubmitted: (value) {},
              autocorrect: true,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (products.isNotEmpty) // Check if data is available
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          ProductModel product = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Container(
                              height: 400,
                              child: Card(
                                child: SizedBox(
                                  height: 600,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        color: Colors.black,
                                        height: 110,
                                        width: double.infinity,
                                        child: SizedBox(
                                          height: 90,
                                          child: CachedNetworkImage(
                                            imageUrl: product.images[0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        product.title,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Posted on:",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${product.creationAt.year}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "-${product.creationAt.month}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "-${product.creationAt.day}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '₹-${product.price}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: (value) {},
              onSubmitted: (value) {},
              autocorrect: true,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<ProductModel>>(
                    future: productProvider.fetchProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductModel> products = snapshot.data!;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    ProductModel product = products[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailPage(
                                                    product: product),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 400,
                                        child: Card(
                                          child: SizedBox(
                                            height: 600,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  color: Colors.black,
                                                  height: 110,
                                                  width: double.infinity,
                                                  child: SizedBox(
                                                    height: 90,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          product.images[0],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  product.title,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Posted on:",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${product.creationAt.year}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "-${product.creationAt.month}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "-${product.creationAt.day}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '₹-${product.price}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Error loading products');
                      } else {
                        return const Text("Loading....");
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
} */