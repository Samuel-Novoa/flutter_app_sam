import 'package:flutter/material.dart';

class Store {
  static final List<Map<String, dynamic>> todoList = [];
}

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  StorePageState createState() => StorePageState();
}

class StorePageState extends State<StorePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showTodoEditDialog(Map<String, dynamic> todo) {
    _titleController.text = todo['title'];
    _descriptionController.text = todo['description'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Edit To-Do'),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
              _titleController.clear();
              _descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _updateTodo(Map<String, dynamic> todo) {
    final index = Store.todoList.indexOf(todo);
    setState(() {
      Store.todoList[index] = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'isCompleted': todo['isCompleted'],
      };
    });
  }

  void _deleteTodo(Map<String, dynamic> todo) {
    setState(() {
      Store.todoList.remove(todo);
    });
  }

  void _toggleComplete(Map<String, dynamic> todo) {
    final index = Store.todoList.indexOf(todo);
    setState(() {
      Store.todoList[index]['isCompleted'] = !todo['isCompleted'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tareas'.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: Color.fromARGB(255, 40, 40, 40)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFAFC8AD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0), // Add padding around the body
        child: Store.todoList.isEmpty
            ? const Center(
                child: Text(
                  'No hay tareas guardadas',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: Store.todoList.length,
                itemBuilder: (context, index) {
                  final todo = Store.todoList[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: todo['isCompleted'],
                        onChanged: (value) {
                          _toggleComplete(todo);
                        },
                      ),
                      title: Text(
                        todo['title'],
                        style: TextStyle(
                          decoration: todo['isCompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: !todo['isCompleted']
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _showTodoEditDialog(todo),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteTodo(todo);
                                  },
                                ),
                              ],
                            )
                          : null,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
