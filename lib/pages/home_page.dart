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
    final auth = ref.watch(authProvider.notifier);
    final todosState = ref.watch(todosProvider);
    final todoProvider = ref.watch(todosProvider.notifier);
    final todos = todoProvider.todos;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const DrawerHeader(
              child: Text("Settings"),
            ),
            ListTile(
              trailing: const Icon(Icons.output),
              title: const Text("Logout"),
              onTap: () => auth.signOut(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("My Todo's"),
        actions: [
          IconButton(
              disabledColor: Colors.grey,
              onPressed: todos.isEmpty ||
                      todos.every((element) => element.togglecheck == false)
                  ? null
                  : () {
                      todoProvider.deleteAllChechedTodos();
                    },
              icon: const Icon(Icons.cleaning_services_outlined)),
        ],
      ),
      body: switch (todosState) {
        AsyncValue(hasValue: true) => const TodosList(),
        AsyncError(error: final error) => Center(
            child: Text('Error $error'),
          ),
        _ => const Center(
            child: CircularProgressIndicator(color: Colors.black),
          ),
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
