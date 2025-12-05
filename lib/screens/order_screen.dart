import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/sandwich.dart';
import '../widgets/quantity_selector.dart';

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
  return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  SandwichType _selectedType = SandwichType.veggieDelight;
  BreadType _selectedBread = BreadType.white;
  bool _isFootlong = false;
  int _quantity = 1;

  void _addToCart() {
    for (int i = 0; i < _quantity; i++) {
      widget.cart.add(Sandwich(
          type: _selectedType, isFootlong: _isFootlong, breadType: _selectedBread));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    Sandwich currentSandwich = Sandwich(
      type: _selectedType,
      isFootlong: _isFootlong,
      breadType: _selectedBread,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Sandwich'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(cart: widget.cart)));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(currentSandwich.image, height: 150),
            const SizedBox(height: 20),
            DropdownButton<SandwichType>(
              value: _selectedType,
              items: SandwichType.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedType = val!;
                });
              },
            ),
            DropdownButton<BreadType>(
              value: _selectedBread,
              items: BreadType.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedBread = val!;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Footlong'),
              value: _isFootlong,
              onChanged: (val) {
                setState(() {
                  _isFootlong = val;
                });
              },
            ),
            QuantitySelector(
              quantity: _quantity,
              onIncrement: () => setState(() => _quantity++),
              onDecrement: () {
                if (_quantity > 1) setState(() => _quantity--);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addToCart,
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
