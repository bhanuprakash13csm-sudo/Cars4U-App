class Car {
  final String name;       // row[1]
  final String location;   // row[2]
  final String year;       // row[3]
  final String kilometers; // row[4]
  final String fuelType;   // row[5]
  final String mileage;    // row[8]
  final String engineType; // row[9]
  final String price;      // row.last

  Car({
    required this.name,
    required this.location,
    required this.year,
    required this.kilometers,
    required this.fuelType,
    required this.mileage,
    required this.engineType,
    required this.price,
  });

  factory Car.fromCsv(List<dynamic> row) {
    return Car(
      name: row.length > 1 ? row[1].toString() : 'Unknown',
      location: row.length > 2 ? row[2].toString() : 'N/A',
      year: row.length > 3 ? row[3].toString() : 'N/A',
      kilometers: row.length > 4 ? row[4].toString() : 'N/A',
      fuelType: row.length > 5 ? row[5].toString() : 'N/A',
      
      mileage: row.length > 8 ? row[8].toString() : 'N/A',
      engineType: row.length > 9 ? row[9].toString() : 'N/A',
      
      price: row.isNotEmpty ? row.last.toString() : 'N/A',
    );
  }
}