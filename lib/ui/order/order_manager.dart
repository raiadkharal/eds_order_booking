class OrderManager {
  // Singleton pattern
  static final OrderManager _instance = OrderManager._internal();

  static OrderManager getInstance() => _instance;

  OrderManager._internal();

  /// Converts units to cartons and remaining items as units
  OrderQuantity calculateOrderQty(
      int productUnitsPerCarton, int orderedUnits, int orderedCartons) {
    int cartons = orderedCartons;
    int units = orderedUnits;

    if (orderedUnits >= productUnitsPerCarton && productUnitsPerCarton > 0) {
      int quotient = orderedUnits ~/ productUnitsPerCarton;
      int remainder = orderedUnits % productUnitsPerCarton;
      cartons += quotient;
      units = remainder;
    }

    return OrderQuantity(units, cartons);
  }

  /// This calculates units in float carton size
  double calculateQtyInCartons(
      int productUnitsPerCarton, int orderedUnits, int orderedCartons) {
    double qtyInCarton = orderedCartons.toDouble();

    if (productUnitsPerCarton > 0) {
      double quotient = orderedUnits / productUnitsPerCarton;
      qtyInCarton += quotient;
    }

    return qtyInCarton;
  }
}

class OrderQuantity {
  int units;
  int cartons;

  OrderQuantity(this.units, this.cartons);

  @override
  String toString() {
    return 'OrderQuantity(units: $units, cartons: $cartons)';
  }
}
