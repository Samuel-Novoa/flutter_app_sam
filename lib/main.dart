import 'package:flutter/material.dart';
import 'src/home_page.dart';
import 'src/description.dart';
import 'src/to_do.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Example',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/description': (context) => const Description(),
        '/to_do': (context) => const ToDo(),
      },
    );
  }
}
