import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/auth_provider.dart';
import 'package:todoapp/providers/todos_provider.dart';

class AddingTodo extends ConsumerStatefulWidget {
  const AddingTodo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<AddingTodo> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController todocontroller = TextEditingController();

  @override
  void dispose() {
    todocontroller.dispose();
    titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = ref.watch(todosProvider.notifier);
    final auth = ref.watch(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add Your Todo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(16)),
            TextField(
              autofocus: true,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              controller: titlecontroller,
              maxLength: 30,
              decoration: InputDecoration(
                hintText: 'Write your title here',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            TextField(
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              controller: todocontroller,
              maxLength: 3000,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Write your todos here',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            TextButton(
              onPressed: titlecontroller.text.isNotEmpty &&
                      todocontroller.text.isNotEmpty
                  ? () {
                      todoProvider.addTodo(
                        titlecontroller.text,
                        todocontroller.text,
                        auth.userId,
                      );

                      context.go('/');
                    }
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
