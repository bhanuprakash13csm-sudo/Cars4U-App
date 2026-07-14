import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Project")),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cars4U Dataset Explorer", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("This application is built using Flutter and dynamically parses the Cars4U dataset from Kaggle.", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Features include:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("• Instant Search Filtering\n• Dark & Light Theme Toggle\n• Real-time CSV Parsing\n• Responsive Design", style: TextStyle(fontSize: 16)),
            Spacer(),
            Center(child: Text("Version 1.0.0")),
          ],
        ),
      ),
    );
  }
}