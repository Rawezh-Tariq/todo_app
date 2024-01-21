import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/todos_provider.dart';
import 'package:todoapp/tools/theme.dart';

class TodosList extends ConsumerWidget {
  const TodosList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(todosProvider);
    final todoProvider = ref.watch(todosProvider.notifier);
    final todos = todoProvider.todos;

    return Column(
      children: [
        if (todosState.isLoading) const LinearProgressIndicator(),
        Expanded(
          child: todos.isEmpty
              ? Center(
                  child: Text('No Todo in the list',
                      style: myTheme.textTheme.bodyLarge),
                )
              : ListView.separated(
                  itemCount: todos.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Column(
                      children: [
                        Dismissible(
                          key: UniqueKey(),
                          background: Container(
                              color: Colors.red,
                              child: const Icon(Icons.delete)),
                          onDismissed: (_) {
                            todoProvider.deleteTodo(todo.todoId);
                          },
                          child: GestureDetector(
                            onTap: () {
                              context.go('/todo/${todo.todoId}', extra: 'kk');
                            },
                            child: ListTile(
                              title: Text(todo.title),
                              subtitle: Text(todo.body, maxLines: 1),
                              leading: Checkbox(
                                value: todo.togglecheck,
                                onChanged: (_) {
                                  todoProvider.togglecheck(todo.todoId);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
