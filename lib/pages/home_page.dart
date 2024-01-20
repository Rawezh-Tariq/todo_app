import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/auth_provider.dart';
import 'package:todoapp/providers/todos_provider.dart';
import 'package:todoapp/widgets/todo_list_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authProviderr = ref.watch(authProvider.notifier);
    final todosState = ref.watch(todosProvider);
    final todosNotifier = ref.watch(todosProvider.notifier);
    final todos = ref.watch(todosProvider).value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo's"),
        leading: IconButton(
          onPressed: () {
            authProviderr.signOut();
            context.go('/auth');
          },
          icon: const Icon(Icons.output_rounded),
        ),
        actions: [
          IconButton(
              onPressed: todos.isEmpty ||
                      todos.every((element) => element.togglecheck == false)
                  ? null
                  : () {
                      todosNotifier.deleteAllChechedTodos();
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
          context.go('/addTodo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
