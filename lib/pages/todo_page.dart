import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providerds/todosprovider.dart';
import 'package:todoapp/tools/theme.dart';

class TodoPage extends ConsumerStatefulWidget {
  final bool togglecheck;
  final int index;
  final String id;
  const TodoPage(
      {super.key,
      required this.togglecheck,
      required this.index,
      required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = ref.watch(todosProvider.notifier);
    final todoProviderrr = ref.watch(todosProvider).value!;

    return todoProviderrr.isNotEmpty && widget.index < todoProviderrr.length
        ? Scaffold(
            appBar: AppBar(
              title: Text(todoProviderrr[widget.index].title),
              leading: IconButton(
                onPressed: () {
                  GoRouter.of(context).go('/');
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                Checkbox(
                  side:
                      myThime.checkboxTheme.side!.copyWith(color: Colors.black),
                  value: todoProviderrr[widget.index].togglecheck,
                  onChanged: (_) {
                    todoProvider.togglecheck(widget.togglecheck);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todoProviderrr[widget.index].body,
                      style: myThime.textTheme.bodyLarge),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context).go(
                                  '/EditTodo/${todoProviderrr[widget.index].title}/${todoProviderrr[widget.index].body}/${widget.togglecheck}/${widget.index}');
                            },
                            child: const Text('edit'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              todoProvider.deleteTodo(widget.id);
                              GoRouter.of(context).go('/');
                            },
                            child: const Text('delet'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const CircularProgressIndicator();
  }
}
