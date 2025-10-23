import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  String _note = ''; // Track the custom note
  final TextEditingController _noteController = TextEditingController();

  // Increase quantity
  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() {
        _quantity++;
        print('Current quantity: $_quantity'); // Debugging line
      });
    }
  }

  // Decrease quantity
  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  @override
  void dispose() {
    _noteController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(
              _quantity,
              'Footlong',
            ),
            const SizedBox(height: 10),
            // TextField for custom notes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a note (e.g., "no onions")',
                ),
                onChanged: (value) {
                  setState(() => _note = value);
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StyledButton(
                  text: 'Add',
                  icon: Icons.add,
                  onPressed: _quantity < widget.maxQuantity ? _increaseQuantity : null,
                  backgroundColor: Colors.green,
                ),
                StyledButton(
                  text: 'Remove',
                  icon: Icons.remove,
                  onPressed: _quantity > 0 ? _decreaseQuantity : null,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Display the note if not empty
            if (_note.isNotEmpty)
              Text(
                'Note: $_note',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;

  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}');
  }
}