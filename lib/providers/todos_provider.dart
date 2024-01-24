import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/tools/todo.dart';
import 'package:uuid/uuid.dart';

final todosProvider = AsyncNotifierProvider<MyTodos, List<Todo>>(MyTodos.new);

final todoProviderFamily = StateProviderFamily(
  (ref, String todoId) {
    final todo = ref
        .watch(todosProvider)
        .value!
        .firstWhere((element) => element.todoId == todoId);
    return todo;
  },
);

class MyTodos extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    final supabaseTodos = await Supabase.instance.client
        .from('todos')
        .select()
        .eq('user_id ', '$userId');
    final todos = supabaseTodos.map((e) => Todo.fromMap(e)).toList();

    return todos;
  }

  Future<void> addTodo(String title, String body, String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final newTodo = Todo(
          title: title,
          body: body,
          todoId: const Uuid().v4(),
          userId: userId,
          togglecheck: false);

      await Supabase.instance.client.from('todos').insert(newTodo.toMap());

      final value = [...?state.value, newTodo];

      return value;
    });
  }

  Future<void> deleteTodo(String todoId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client
          .from('todos')
          .delete()
          .eq('todo_id', todoId);
      final value = [...?state.value];
      value.removeWhere((element) => element.todoId == todoId);

      return value;
    });
  }

  Future<void> updateTodo(String todoId, String title, String body) async {
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client
          .from('todos')
          .update({'title': title, 'body': body}).match({'todo_id': todoId});
      final value = [...?state.value];
      final oldTodo = value.firstWhere((element) => element.todoId == todoId);
      final index = value.indexOf(oldTodo);
      value[index] = oldTodo.copyWith(
        title: title,
        body: body,
      );

      return value;
    });
  }

  Future<void> togglecheck(String todoId) async {
    final todo = state.value?.firstWhere((element) => element.todoId == todoId);
    final togglecheck = !(todo?.togglecheck ?? false);
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client
          .from('todos')
          .update({'togglecheck': togglecheck}).eq('todo_id', todoId);

      final value = [...?state.value];
      final oldTodo = value.firstWhere((element) => element.todoId == todoId);
      final index = value.indexOf(oldTodo);
      value[index] = oldTodo.copyWith(
        togglecheck: !oldTodo.togglecheck,
      );

      return value;
    });
  }

  Future<void> deleteAllChechedTodos() async {
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client
          .from('todos')
          .delete()
          .eq('togglecheck', true);
      final value = [...?state.value];
      value.removeWhere((element) => element.togglecheck == true);
      return value;
    });
  }

  List<Todo> get todos => state.value ?? [];
}
