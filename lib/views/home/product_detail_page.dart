import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:proplus/model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page!.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                color: Colors.black,
                height: 220,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.product.images.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: widget.product.images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Positioned(
                top: 180, // Adjust the top position as needed
                left: 0, // Adjust the left position as needed
                right: 0, // Adjust the right position as needed
                child: DotsIndicator(
                  dotsCount: widget.product.images.length,
                  position: _currentPage,
                  decorator: const DotsDecorator(
                    activeColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: '₹-${widget.product.price}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const Text(
                      'Product details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 160,
                    ),
                    Text(
                      "${widget.product.creationAt.year}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "-${widget.product.creationAt.month}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "-${widget.product.creationAt.day}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    const Text(
                      "Product ID",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      widget.product.id.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Text(
                        widget.product.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(500, 60),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Book now',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(500, 60),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      side: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    backgroundColor:
                        Colors.white, 
                    foregroundColor: Colors.red, 
                  ),
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
