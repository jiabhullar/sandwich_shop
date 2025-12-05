import 'sandwich.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({required this.sandwich, this.quantity = 1});
}

class Cart {
  final List<CartItem> items = [];

  void add(Sandwich sandwich) {
    for (var item in items) {
      if (item.sandwich.type == sandwich.type &&
          item.sandwich.isFootlong == sandwich.isFootlong &&
          item.sandwich.breadType == sandwich.breadType) {
        item.quantity++;
        return;
      }
    }
    items.add(CartItem(sandwich: sandwich));
  }

  void remove(CartItem item) {
    items.remove(item);
  }

  void clear() {
    items.clear();
  }

  int get countOfItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.quantity * item.sandwich.price);
}
