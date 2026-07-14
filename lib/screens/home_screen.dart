import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../providers/theme_provider.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Car> _allCars = [];
  List<Car> _filteredCars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _loadCSV() async {
    try {
      final rawData = await rootBundle.loadString("assets/cars4u.csv");
      final converter = const CsvToListConverter();
      List<List<dynamic>> listData = converter.convert(rawData);
      
      setState(() {
        _allCars = listData.skip(1).map((row) => Car.fromCsv(row)).toList();
        _filteredCars = _allCars;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading CSV: $e");
      setState(() { _isLoading = false; });
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Car> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allCars;
    } else {
      results = _allCars.where((car) {
        final searchString = '${car.make} ${car.model} ${car.year}'.toLowerCase();
        return searchString.contains(enteredKeyword.toLowerCase());
      }).toList();
    }
    setState(() { _filteredCars = results; });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Cars Inventory", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen())),
          ),
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.blueAccent,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Type "h" for Honda, Hyundai...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF0F172A) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              
              Expanded(
                child: _filteredCars.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text("No cars found matching your search", 
                              style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredCars.length,
                        itemBuilder: (context, index) {
                          final car = _filteredCars[index];
                          return Card(
                            elevation: 4,
                            shadowColor: Colors.black26,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.directions_car, color: Colors.blueAccent, size: 30),
                              ),
                              title: Text('${car.make} ${car.model}', 
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Year: ${car.year}  •  Fuel: ${car.fuelType}'),
                              ),
                              trailing: Text('₹${car.price}', 
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
    );
  }
}