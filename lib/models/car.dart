class Car {
  final String make;
  final String model;
  final String year;
  final String fuelType;
  final String price;

  Car({
    required this.make, 
    required this.model, 
    required this.year, 
    required this.fuelType, 
    required this.price
  });

  factory Car.fromCsv(List<dynamic> row) {
    return Car(
      make: row.isNotEmpty ? row[0].toString() : 'Unknown',
      model: row.length > 1 ? row[1].toString() : 'Unknown',
      year: row.length > 2 ? row[2].toString() : 'N/A',
      fuelType: row.length > 3 ? row[3].toString() : 'N/A',
      price: row.length > 4 ? row[4].toString() : 'N/A',
    );
  }
}