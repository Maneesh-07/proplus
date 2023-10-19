import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proplus/views/login/login_page.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 7),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const LoginPage(),
            ));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/Animation - 1697476133181.json",
              width: 250,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
