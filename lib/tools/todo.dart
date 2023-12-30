import 'dart:convert';

class Todo {
  final String id;
  final String title;
  final String body;
  final bool togglecheck;
  const Todo(
      {required this.body,
      required this.title,
      required this.togglecheck,
      required this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.togglecheck == togglecheck;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ body.hashCode ^ togglecheck.hashCode;
  }

  Todo copyWith({
    String? id,
    String? title,
    String? body,
    bool? togglecheck,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      togglecheck: togglecheck ?? this.togglecheck,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'togglecheck': togglecheck,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      togglecheck: map['togglecheck'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
