import 'package:flutter/material.dart';
import 'to_do.dart';
import 'store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the To-Do App'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToDo()),
                );
              },
              child: const Text('Go to To-Do'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StorePage()),
                );
              },
              child: const Text('View To-Dos'),
            ),
          ],
        ),
      ),
    );
  }
}