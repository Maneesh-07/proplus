
import 'package:flutter/material.dart';
import 'package:proplus/views/ProductAdding/product_adding.dart';
import 'package:proplus/views/home/home_page.dart';
import 'package:proplus/views/home/widgets/bottom.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({
    super.key,
  });

  final _pages = [
    const HomePage(),
    const ProductAddingScreen(),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationScreen(),
    );
  }
}
