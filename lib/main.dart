import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proplus/controller/add_product_provider.dart';
import 'package:proplus/controller/product_provider.dart';
import 'package:proplus/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductAddProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          fontFamily: GoogleFonts.lato().fontFamily,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
