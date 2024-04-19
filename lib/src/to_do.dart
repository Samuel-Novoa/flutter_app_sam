import 'package:flutter/material.dart';
import '../components/menu.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTodo() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      setState(() {
        _todoList.add({
          'title': _titleController.text,
          'description': _descriptionController.text,
        });
        _titleController.clear();
        _descriptionController.clear();
      });
    }
  }

  void _showTodoDetails(Map<String, dynamic> todo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(todo['title']),
        content: Text(todo['description']),
        actions: [
          TextButton(
            onPressed: () {
              // Edit to-do item
              Navigator.pop(context);
            },
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              // Delete to-do item
              setState(() {
                _todoList.remove(todo);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
      ),
      drawer: const MenuPage(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter description',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: const Text('Add To-Do'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final todo = _todoList[index];
                return Card(
                  child: ListTile(
                    title: Text(todo['title']),
                    onTap: () => _showTodoDetails(todo),
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
