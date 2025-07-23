import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/todo_module/todo_provider.dart';
import 'todo_model.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Riverpod CRUD Todo'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return todoTile(todoList[index], ref);
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            showAddTodoDialog(context, ref);
          },
          tooltip: 'Add Todo',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<dynamic> showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Todo"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  controller: descriptionController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a description';
                  //   }
                  //   return null;
                  // },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(todoProvider.notifier).addTodo(
                      titleController.text, descriptionController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Padding todoTile(Todo todo, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTodoStatus(todo),
              Text(
                todo.title,
                style: TextStyle(
                    decoration: todo.todoStatus == TodoStatus.completed
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ],
          ),
          subtitle: (todo.description != null && todo.description!.isNotEmpty)
              ? Text(todo.description!)
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              getButton(todo, ref),
              // IconButton(
              //   icon: const Icon(Icons.delete),
              //   onPressed: () {
              //     // Implement your delete logic here
              //     ref.read(todoProvider.notifier).deleteTodo(todo.id);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getButton(Todo todo, WidgetRef ref) {
    switch (todo.todoStatus) {
      case TodoStatus.open:
        return IconButton(
          icon: const Icon(Icons.play_circle_outline),
          onPressed: () {
            // Implement your check logic here
            ref.read(todoProvider.notifier).updateTodo(
                  id: todo.id,
                  todoStatus: TodoStatus.inProgress,
                );
          },
        );
      case TodoStatus.inProgress:
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () {
                // Implement your check logic here
                ref.read(todoProvider.notifier).updateTodo(
                      id: todo.id,
                      todoStatus: TodoStatus.completed,
                    );
              },
            ),
            IconButton(
              icon: const Icon(Icons.pause_circle_outline),
              onPressed: () {
                // Implement your check logic here
                ref.read(todoProvider.notifier).updateTodo(
                      id: todo.id,
                      todoStatus: TodoStatus.onHold,
                    );
              },
            ),
          ],
        );
      case TodoStatus.onHold:
        return IconButton(
          icon: const Icon(Icons.play_circle_outline),
          onPressed: () {
            // Implement your check logic here
            ref.read(todoProvider.notifier).updateTodo(
                  id: todo.id,
                  todoStatus: TodoStatus.inProgress,
                );
          },
        );
      case TodoStatus.completed:
        return IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Implement your check logic here
            ref.read(todoProvider.notifier).deleteTodo(todo.id);
          },
        );
    }
  }

  Text getTodoStatus(Todo todo) {
    switch (todo.todoStatus) {
      case TodoStatus.open:
        return const Text(
          "Open",
          style: TextStyle(color: Colors.lightGreen),
        );
      case TodoStatus.inProgress:
        return const Text(
          "In Progress",
          style: TextStyle(color: Colors.blue),
        );
      case TodoStatus.onHold:
        return const Text(
          "On Hold",
          style: TextStyle(color: Colors.grey),
        );
      case TodoStatus.completed:
        return const Text(
          "Completed",
          style: TextStyle(color: Colors.green),
        );
    }
  }
}
