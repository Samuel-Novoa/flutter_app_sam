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
        backgroundColor: const Color(0xFFF2F1EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Editar la tarea'.toUpperCase(),
              style: const TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
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
            const SizedBox(height: 10),
            _buildTextField(_titleController, 'Digitar título'),
            const SizedBox(height: 10),
            _buildTextField(_descriptionController, 'Digitar descripción',
                multiline: true),
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

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool multiline = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        minLines: multiline ? 3 : null,
        maxLines: multiline ? 6 : null,
        keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          border: InputBorder.none,
        ),
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

  void _showTodoDetailsDialog(Map<String, dynamic> todo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF2F1EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detalles de la tarea'.toUpperCase(),
              style: const TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Título',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${todo['titulo']}'),
            const SizedBox(height: 10),
            const Text(
              'Descripción',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${todo['descripcion']}'),
            const SizedBox(height: 10),
            // Text('Completa: ${todo['esCompleta'] ? 'Sí' : 'No'}'),
          ],
        ),
      ),
    );
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
                    color: Colors.white,
                    child: ListTile(
                      onTap: () => _showTodoDetailsDialog(todo),
                      leading: Checkbox(
                        value:
                            todo['esCompleta'] ?? false, // Verificación de nulo
                        tristate: false, // No se necesita un estado intermedio
                        onChanged: (value) {
                          _toggleComplete(todo);
                        },
                      ),
                      title: Text(
                        todo['titulo'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration:
                              todo['esCompleta'] == true // Verificación de true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                      ),
                      trailing: todo['esCompleta'] !=
                              true // Verificación de true
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _showTodoEditDialog(todo),
                                  tooltip: 'Editar',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteTodo(todo),
                                  tooltip: 'Eliminar',
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
