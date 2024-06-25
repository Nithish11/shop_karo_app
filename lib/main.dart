import 'package:flutter/material.dart';
import 'package:e_commerce_app/home/home_page.dart';
import 'package:e_commerce_app/product/product_page.dart';
import 'package:e_commerce_app/cart/cart_page.dart';
import 'package:e_commerce_app/profile/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/product': (context) => ProductPage(),
        '/cart': (context) => CartPage(
              product: {},
            ),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
