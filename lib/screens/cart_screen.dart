import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final Cart cart;
  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final item = cart.items[index];
          return ListTile(
            leading: Image.asset(item.sandwich.image, width: 50),
            title: Text(item.sandwich.name),
            subtitle: Text('Quantity: ${item.quantity}'),
            trailing: Text('\$${(item.sandwich.price * item.quantity).toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          child: Text('Checkout (\$${cart.totalPrice.toStringAsFixed(2)})'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckoutScreen(cart: cart)),
            );
          },
        ),
      ),
    );
  }
}
