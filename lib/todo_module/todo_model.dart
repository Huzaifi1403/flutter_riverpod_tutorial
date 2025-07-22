enum TodoStatus { open, inProgress, onHold, completed }

class Todo {
  final String id;
  final String title;
  String? description;
  TodoStatus todoStatus;

  Todo({
    required this.id,
    required this.title,
    this.description = "",
    this.todoStatus = TodoStatus.open,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? todoStatus,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      todoStatus: todoStatus ?? this.todoStatus,
    );
  }
}
