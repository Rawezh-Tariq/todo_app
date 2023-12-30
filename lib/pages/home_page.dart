import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providerds/todosprovider.dart';
import 'package:todoapp/tools/theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todosState = ref.watch(todosProvider);
    // final todosNotifier = ref.watch(todosProvider.notifier);
    ref.listen(todosProvider, (previous, next) {
      if (previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo's"),
        actions: [
          IconButton(
              onPressed: () {
                // todosNotifier.deleteAllTodos();
              },
              icon: const Icon(Icons.cleaning_services_outlined)),
        ],
      ),
      body: switch (todosState) {
        AsyncValue(hasValue: true) => const TodosList(),
        AsyncError(:final error) => Center(
            child: Text('Error $error'),
          ),
        _ => const Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go('/AddTodo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
              : ReorderableListView.builder(
                  itemCount: todos.length,
                  onReorder: (old, neww) {
                    todosNotifier.reOrderTodo(
                      old,
                      neww,
                    );
                  },
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return Column(
                      key: Key('$index'),
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).go(
                                '/TodoPage/${todo.id}/$index/${todo.togglecheck}');
                          },
                          child: ListTile(
                            title: Text(
                              todo.title,
                            ),
                            subtitle: Text(
                              todo.body.replaceRange(0, null, '. . .'),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                todosNotifier.deleteTodo(todo.id);
                              },
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.amber),
                            ),
                            leading: Checkbox(
                              value: todo.togglecheck,
                              onChanged: (_) {
                                todosNotifier.togglecheck(todo.togglecheck);
                              },
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
