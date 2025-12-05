import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  test('Add items to cart and total', () {
    final cart = Cart();
    final sandwich = Sandwich(type: SandwichType.ham, isFootlong: false, breadType: BreadType.wheat);
    cart.add(sandwich);
    cart.add(sandwich);
    expect(cart.countOfItems, 2);
    expect(cart.totalPrice, 6.5 * 2);
  });
}
