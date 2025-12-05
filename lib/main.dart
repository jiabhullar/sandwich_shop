import 'package:flutter/material.dart';
import 'models/cart.dart';
import 'screens/order_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/app_styles.dart';

void main() {
  runApp(const SandwichShopApp());
}

class SandwichShopApp extends StatelessWidget {
  const SandwichShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => OrderScreen(cart: Cart()),
        '/cart': (context) => CartScreen(),
        '/checkout': (context) => CheckoutScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
