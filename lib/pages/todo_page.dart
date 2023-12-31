import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providerds/todosprovider.dart';
import 'package:todoapp/tools/theme.dart';

class TodoPage extends ConsumerStatefulWidget {
  final String id;
  const TodoPage({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(todoProviderFamily(widget.id));
    final todoProvider = ref.watch(todosProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Checkbox(
            side: myThime.checkboxTheme.side!.copyWith(color: Colors.black),
            value: todo.togglecheck,
            onChanged: (_) {
              todoProvider.togglecheck(todo.id);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.body, style: myThime.textTheme.bodySmall),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).go(
                            '/EditTodo/${todo.title}/${todo.body}/${todo.id}');
                      },
                      child: const Text('edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        todoProvider.deleteTodo(todo.id);
                        GoRouter.of(context).go('/');
                      },
                      child: const Text('delet'),
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
