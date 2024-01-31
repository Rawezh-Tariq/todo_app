import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/todos_provider.dart';
import 'package:todoapp/tools/theme.dart';
import 'package:todoapp/widgets/my_card.dart';

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
        todosState.hasValue
            ? Expanded(
                child: todos.isEmpty
                    ? Center(
                        child: Text('No Todo in the list',
                            style: myTheme.textTheme.bodyLarge),
                      )
                    : ListView.separated(
                        itemCount: todos.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return Opacity(
                            opacity: todo.togglecheck ? 0.5 : 1,
                            child: MyCard(todoId: todo.todoId),
                          );
                        },
                      ),
              )
            : const Center(),
        todosState.isLoading
            ? const LinearProgressIndicator(
                color: Colors.black,
              )
            : const Center(),
      ],
    );
  }
}
