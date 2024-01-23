import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/todos_provider.dart';
import 'package:todoapp/tools/theme.dart';

class TodoPage extends ConsumerStatefulWidget {
  final String todoId;
  const TodoPage({super.key, required this.todoId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(todoProviderFamily(widget.todoId));
    final todoProvider = ref.watch(todosProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Checkbox(
            side: myTheme.checkboxTheme.side!.copyWith(color: Colors.black),
            value: todo.togglecheck,
            onChanged: (_) {
              todoProvider.togglecheck(todo.todoId);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.body, style: myTheme.textTheme.bodySmall),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.go(
                            '/editTodo/${todo.title}/${todo.body}/${todo.todoId}');
                      },
                      child: Text('edit', style: myTheme.textTheme.bodySmall),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        todoProvider.deleteTodo(todo.todoId);
                        context.go('/');
                      },
                      child: Text('delet', style: myTheme.textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
