import 'package:flutter/material.dart';
import '../components/menu.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      drawer: const MenuPage(),
      body: const Center(
        child: Text('This is the Contact page.'),
      ),
    );
  }
}