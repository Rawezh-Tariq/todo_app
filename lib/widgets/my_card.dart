import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/todos_provider.dart';
import 'package:todoapp/tools/theme.dart';

class MyCard extends ConsumerWidget {
  final String todoId;
  const MyCard({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoProvider = ref.watch(todosProvider.notifier);
    final todo = ref.watch(todoProviderFamily(todoId))!;
    return Dismissible(
      background: const Icon(Icons.delete),
      onDismissed: (_) {
        todoProvider.deleteTodo(todo.todoId);
      },
      key: UniqueKey(),
      child: GestureDetector(
        onTap: () {
          context.go('/todo/${todo.todoId}');
        },
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(todo.title,
                    style: myTheme.textTheme.bodySmall!.copyWith(
                        decoration: todo.togglecheck
                            ? TextDecoration.lineThrough
                            : null)),
                Checkbox(
                  activeColor: Colors.black,
                  value: todo.togglecheck,
                  onChanged: (_) {
                    todoProvider.togglecheck(todo.todoId);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
