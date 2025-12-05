import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  test('Sandwich name and image', () {
    final sandwich = Sandwich(type: SandwichType.veggieDelight, isFootlong: true, breadType: BreadType.white);
    expect(sandwich.name, 'Footlong VeggieDelight');
    expect(sandwich.image, 'assets/images/veggieDelight_footlong.png');
  });
}
