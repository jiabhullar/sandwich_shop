enum SandwichType { veggieDelight, turkey, ham }

enum BreadType { white, wheat, multigrain }

class Sandwich {
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;

  Sandwich({
    required this.type,
    required this.isFootlong,
    required this.breadType,
  });

  String get name {
    String size = isFootlong ? "Footlong" : "Six Inch";
    String typeName = type.name; // veggieDelight, turkey, ham
    return "$size ${typeName[0].toUpperCase()}${typeName.substring(1)}";
  }

  double get price {
    switch (type) {
      case SandwichType.veggieDelight:
        return isFootlong ? 8.0 : 5.0;
      case SandwichType.turkey:
        return isFootlong ? 9.0 : 6.0;
      case SandwichType.ham:
        return isFootlong ? 9.5 : 6.5;
    }
  }

  String get image {
    String typeName = type.name;
    String size = isFootlong ? "footlong" : "six_inch";
    return "assets/images/${typeName}_${size}.png";
  }
}
