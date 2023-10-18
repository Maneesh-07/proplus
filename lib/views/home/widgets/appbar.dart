
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      // leading: const Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //     ),
      //   ],
      // ),
      centerTitle: true,
      title:  Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      elevation: 1.0,
      shadowColor: Colors.black,
    );
  }
}
