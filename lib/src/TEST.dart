import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
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
            child: Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              // Delete to-do item
              setState(() {
                _todoList.remove(todo);
              });
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter title',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter description',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: Text('Add To-Do'),
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
