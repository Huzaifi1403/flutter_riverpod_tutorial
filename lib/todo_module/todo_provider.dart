import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/todo_module/todo_model.dart';

class TodoProvider extends StateNotifier<List<Todo>> {
  TodoProvider() : super(sampleTodos);

  void addTodo(String title, String description) {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      todoStatus: TodoStatus.open,
    );
    state = [...state, newTodo];
  }

  void updateTodo(
      {String? id,
      String? title,
      String? description,
      TodoStatus? todoStatus}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(
            title: title ?? todo.title,
            description: description ?? todo.description,
            todoStatus: todoStatus ?? todo.todoStatus,
          )
        else
          todo,
    ];
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoProvider =
    StateNotifierProvider<TodoProvider, List<Todo>>((ref) => TodoProvider());

final List<Todo> sampleTodos = [
  Todo(
    id: '1',
    title: 'Learn Flutter State Management',
    description: 'Study Riverpod and StateNotifier',
    todoStatus: TodoStatus.inProgress,
  ),
  Todo(
    id: '2',
    title: 'Build Todo App',
    description: 'Implement CRUD operations',
    todoStatus: TodoStatus.open,
  ),
  Todo(
    id: '3',
    title: 'Deploy App to App Store',
    description: 'Prepare release build and submit',
    todoStatus: TodoStatus.onHold,
  ),
];
