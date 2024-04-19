import 'package:flutter/material.dart';
import '../components/menu.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      drawer: const MenuPage(),
      body: const Center(
        child: Text('This is the About page.'),
      ),
    );
  }
}
