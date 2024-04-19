import 'package:flutter/material.dart';
import '../components/menu.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
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
    _titleController.text = todo['title'];
    _descriptionController.text = todo['description'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit To-Do'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Enter title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Enter description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _updateTodo(todo);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _updateTodo(Map<String, dynamic> todo) {
    final index = _todoList.indexOf(todo);
    setState(() {
      _todoList[index] = {
        'title': _titleController.text,
        'description': _descriptionController.text,
      };
    });
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showTodoDetails(todo),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _todoList.remove(todo);
                            });
                          },
                        ),
                      ],
                    ),
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
