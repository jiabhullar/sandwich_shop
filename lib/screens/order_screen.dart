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
  final Cart _cart = Cart();
  final TextEditingController _notesController = TextEditingController();

  SandwichType _selectedType = SandwichType.veggieDelight;
  bool _isFootlong = false;
  BreadType _selectedBread = BreadType.white;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() {
      setState(() {});
    });
  }
    @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _navigateToProfile() async {
    final Map<String, String>? result =
        await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute<Map<String, String>>(
        builder: (BuildContext context) => const ProfileScreen(),
      ),
    );

    final bool hasResult = result != null;
    final bool widgetStillMounted = mounted;

    if (hasResult && widgetStillMounted) {
      _showWelcomeMessage(result);
    }
  }

  void _showWelcomeMessage(Map<String, String> profileData) {
    final String name = profileData['name']!;
    final String location = profileData['location']!;
    final String welcomeMessage = 'Welcome, $name! Ordering from $location';

    final SnackBar welcomeSnackBar = SnackBar(
      content: Text(welcomeMessage),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(welcomeSnackBar);
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
