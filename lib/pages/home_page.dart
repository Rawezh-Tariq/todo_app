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
    final todosNotifier = ref.watch(todosProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo's"),
        actions: [
          IconButton(
              onPressed: () {
                todosNotifier.deleteAllTodos();
              },
              icon: const Icon(Icons.cleaning_services_outlined)),
        ],
      ),
      body: switch (todosState) {
        AsyncData(value: final todos) => todos.isEmpty
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
                  return Column(
                    key: Key('$index'),
                    children: [
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context)
                              .go('/TodoPage/${todos[index].id}/$index');
                        },
                        child: ListTile(
                          title: Text(
                            todos[index].title,
                          ),
                          subtitle: Text(
                            todos[index].body!.replaceRange(0, null, '. . .'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              todosNotifier.deleteTodos(todos[index].id!);
                            },
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.amber),
                          ),
                          leading: Checkbox(
                            value: todos[index].isItChechked,
                            onChanged: (_) {
                              todosNotifier.togglecheck(todos[index].id!);
                            },
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
        AsyncError(:final error) => Center(child: Text('Error $error')),
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
