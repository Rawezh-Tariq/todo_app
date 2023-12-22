
import 'dart:convert';

class Todo {
  final String? id;
  final String title;
  final String? body;
  final bool isItChechked;
  const Todo(
      {this.body, required this.title, this.isItChechked = false, this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.isItChechked == isItChechked;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ body.hashCode ^ isItChechked.hashCode;
  }

  Todo copyWith({
    String? id,
    String? title,
    String? body,
    bool? isItChechked,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isItChechked: isItChechked ?? this.isItChechked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'isItChechked': isItChechked,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      body: map['body'] != null ? map['body'] as String : null,
      isItChechked: map['isItChechked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
