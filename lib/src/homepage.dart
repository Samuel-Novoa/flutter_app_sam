import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rounded Image
            ClipOval(
              child: Image.asset(
                'assets/logo-app.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0), // Spacing

            // Centered Title
            const Text(
              'SnapNote',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0), // Spacing

            // Text under Title
            const Text(
              'Bienvenido a SnapNote',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 32.0), // Spacing
          ],
        ),
      ),
    );
  }
}
