import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/todos_provider.dart';

class EditingPage extends ConsumerStatefulWidget {
  final String title;
  final String body;
  final String todoId;

  const EditingPage(
      {super.key,
      required this.title,
      required this.body,
      required this.todoId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditingPageState();
}

class _EditingPageState extends ConsumerState<EditingPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController todocontroller = TextEditingController();

  String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter a title';
    }
    return null;
  }

  String? bodyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter a body';
    }
    return null;
  }

  @override
  void initState() {
    titlecontroller.text = widget.title;
    todocontroller.text = widget.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = ref.watch(todosProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/todo/${widget.todoId}');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('edit Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(16)),
              TextFormField(
                validator: titleValidator,
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                controller: titlecontroller,
                decoration: const InputDecoration(
                  hintText: 'Write your title here',
                ),
              ),
              const SizedBox(height: 100),
              TextFormField(
                validator: bodyValidator,
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                controller: todocontroller,
                minLines: 1,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Write your todos here',
                ),
              ),
              const SizedBox(height: 100),
              TextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    todoProvider.updateTodo(
                      widget.todoId,
                      titlecontroller.text,
                      todocontroller.text,
                    );
                    context.go('/todo/${widget.todoId}');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
