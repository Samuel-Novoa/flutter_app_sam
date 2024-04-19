import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('To Do'),
            onTap: () {
              Navigator.pushNamed(context, '/to_do');
            },
          ),
          ListTile(
            title: const Text('Description'),
            onTap: () {
              Navigator.pushNamed(context, '/description');
            },
          ),
        ],
      ),
    );
  }
}
