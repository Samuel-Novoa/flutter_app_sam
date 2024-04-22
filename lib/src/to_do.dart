import 'package:flutter/material.dart';
import 'store.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  ToDoState createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTodo() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      setState(() {
        Store.todoList.add({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'isCompleted': false,
        });
        _titleController.clear();
        _descriptionController.clear();
      });
    }
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Agregar una nueva tarea',
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
              _addTodo();
              Navigator.pop(context);
            },
            child: const Text('Add'),
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

  void _showTodoDetails(Map<String, dynamic> todo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('To-Do Details'),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed:
                  !todo['isCompleted'] ? () => _showTodoDetails(todo) : null,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Titulo: ${todo['title']}'),
            Text('Description: ${todo['description']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showTodoEditDialog(todo);
            },
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              _deleteTodo(todo);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

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
              _titleController.clear(); // Clear fields after updating
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
          'Agregar Tarea'.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: Color.fromARGB(255, 40, 40, 40)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF88AB8E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0), // Add padding around the Column
        child: Column(
          children: [
            Expanded(
              child: Store.todoList.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay tareas agregadas',
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
                              onChanged: (value) => _toggleComplete(todo),
                            ),
                            title: Text(
                              todo['title'],
                              style: TextStyle(
                                decoration: todo['isCompleted']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            onTap: () => _showTodoDetails(todo),
                            trailing: !todo['isCompleted']
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () =>
                                            _showTodoEditDialog(todo),
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
          ],
        ),
      ),
      floatingActionButton: Tooltip(
        message: 'Agregar una nueva tarea',
        child: FloatingActionButton(
          onPressed: _showAddTodoDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
