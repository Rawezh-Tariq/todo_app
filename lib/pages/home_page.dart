import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providerds/todosprovider.dart';
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
    final todosState = ref.watch(todosProvider);
    final todosNotifier = ref.watch(todosProvider.notifier);
    final todos = ref.watch(todosProvider).value ?? [];
    // ref.listen(todosProvider, (previous, next) {
    //   if (previous?.error != next.error) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(next.error.toString()),
    //       ),
    //     );
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo's"),
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
          GoRouter.of(context).go('/AddTodo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
