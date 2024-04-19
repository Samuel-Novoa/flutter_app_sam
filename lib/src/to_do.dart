import 'package:flutter/material.dart';
import '../components/menu.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
      ),
      drawer: const MenuPage(),
      body: const Center(
        child: Text('This is the to do page.'),
      ),
    );
  }
}
