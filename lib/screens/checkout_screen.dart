import 'package:flutter/material.dart';
import '../models/cart.dart';

class CheckoutScreen extends StatelessWidget {
  final Cart cart;
  const CheckoutScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total Items: ${cart.countOfItems}', style: const TextStyle(fontSize: 18)),
            Text('Total Price: \$${cart.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Confirmed!')),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
