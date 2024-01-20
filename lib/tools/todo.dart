import 'dart:convert';

class Todo {
  final String todoId;
  final String? userId;
  final String title;
  final String body;
  final bool togglecheck;
  const Todo(
      {required this.body,
      required this.title,
      required this.togglecheck,
      required this.todoId,
      this.userId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.todoId == todoId &&
        other.userId == userId &&
        other.title == title &&
        other.body == body &&
        other.togglecheck == togglecheck;
  }

  @override
  int get hashCode {
    return todoId.hashCode ^
        title.hashCode ^
        body.hashCode ^
        togglecheck.hashCode ^
        userId.hashCode;
  }

  Todo copyWith({
    String? todoId,
    String? title,
    String? body,
    bool? togglecheck,
    String? userId,
  }) {
    return Todo(
      todoId: todoId ?? this.todoId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      togglecheck: togglecheck ?? this.togglecheck,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todo_id': todoId,
      'user_id': userId,
      'title': title,
      'body': body,
      'togglecheck': togglecheck,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todoId: map['todo_id'] as String,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      togglecheck: map['togglecheck'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
