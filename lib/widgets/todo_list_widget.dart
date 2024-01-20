import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/providers/todos_provider.dart';
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
    final isIt = todos.any((element) =>
        element.userId != Supabase.instance.client.auth.currentUser?.id);
    isIt ? ref.invalidate(todosProvider) : null;

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
                            todosNotifier.deleteTodo(todo.todoId);
                          },
                          child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).go('/todo/${todo.todoId}');
                            },
                            child: ListTile(
                              title: Text(todo.title),
                              subtitle: Text(todo.body, maxLines: 1),
                              leading: Checkbox(
                                value: todo.togglecheck,
                                onChanged: (_) {
                                  todosNotifier.togglecheck(todo.todoId);
                                },
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  final user =
                                      Supabase.instance.client.auth.currentUser;
                                  print(user?.email);
                                },
                                icon: const Icon(Icons.access_alarms),
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
