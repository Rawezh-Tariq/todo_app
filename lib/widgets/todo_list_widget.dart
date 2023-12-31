import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providerds/todosprovider.dart';
import 'package:todoapp/tools/theme.dart';

class TodosList extends ConsumerWidget {
  const TodosList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(todosProvider);
    final todosNotifier = ref.watch(todosProvider.notifier);
    final todos = todosState.value!;

    return Column(
      children: [
        if (todosState.isLoading) const LinearProgressIndicator(),
        Expanded(
          child: todos.isEmpty
              ? Center(
                  child: Text('No Todo in the list',
                      style: myThime.textTheme.bodyLarge),
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
                            todosNotifier.deleteTodo(todo.id);
                          },
                          child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).go('/TodoPage/${todo.id}');
                            },
                            child: ListTile(
                              title: Text(todo.title),
                              subtitle: Text(todo.body, maxLines: 1),
                              leading: Checkbox(
                                value: todo.togglecheck,
                                onChanged: (_) {
                                  todosNotifier.togglecheck(todo.id);
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
