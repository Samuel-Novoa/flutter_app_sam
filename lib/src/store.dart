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
    _titleController.text = todo['titulo'];
    _descriptionController.text = todo['descripcion'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Editar la tarea'),
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
              decoration: const InputDecoration(hintText: 'Ingresar el título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Ingresar la descripción'),
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
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _updateTodo(Map<String, dynamic> todo) {
    final index = Store.todoList.indexOf(todo);
    setState(() {
      Store.todoList[index] = {
        'titulo': _titleController.text,
        'descripcion': _descriptionController.text,
        'esCompleta': todo['esCompleta'],
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
      Store.todoList[index]['esCompleta'] = !todo['esCompleta'];
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
        padding: const EdgeInsets.all(30.0),
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
                        value: todo['esCompleta'] ?? false, // Verificación de nulo
                        tristate: false, // No se necesita un estado intermedio
                        onChanged: (value) {
                          _toggleComplete(todo);
                        },
                      ),
                      title: Text(
                        todo['titulo'],
                        style: TextStyle(
                          decoration: todo['esCompleta'] == true // Verificación de true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: todo['esCompleta'] != true // Verificación de true
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