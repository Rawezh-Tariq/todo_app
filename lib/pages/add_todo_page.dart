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
  final formKey = GlobalKey<FormState>();
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _todocontroller = TextEditingController();

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
  void dispose() {
    _todocontroller.dispose();
    _titlecontroller.dispose();
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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(16)),
              TextFormField(
                validator: titleValidator,
                autofocus: true,
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                controller: _titlecontroller,
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
                controller: _todocontroller,
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
                    todoProvider.addTodo(
                      _titlecontroller.text,
                      _todocontroller.text,
                      auth.userId,
                    );

                    context.go('/');
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
