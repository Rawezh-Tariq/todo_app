import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/todos_provider.dart';
import 'package:todoapp/tools/theme.dart';

class TodoPage extends ConsumerWidget {
  final String todoId;
  const TodoPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProviderFamily(todoId));
    final todoProvider = ref.watch(todosProvider.notifier);
    final todosState = ref.watch(todosProvider);
    if (todo == null) {
      return Scaffold(
          body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text('go_Home')),
      ));
    }
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
            checkColor: Colors.white,
            fillColor: const MaterialStatePropertyAll(Colors.black),
            shape: const RoundedRectangleBorder(),
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
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                        context.go(
                            '/editTodo/${todo.title}/${todo.body}/${todo.todoId}');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black),
                      onPressed: () {
                        todoProvider.deleteTodo(todo.todoId);
                        context.go('/');
                      },
                    ),
                  ],
                ),
              ),
            ),
            todosState.isLoading
                ? const LinearProgressIndicator(
                    color: Colors.black,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
