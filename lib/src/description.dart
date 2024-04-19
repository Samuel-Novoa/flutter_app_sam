import 'package:flutter/material.dart';
import '../components/menu.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description'),
      ),
      drawer: const MenuPage(),
      body: const Center(
        child: Text('This is the description page.'),
      ),
    );
  }
}
