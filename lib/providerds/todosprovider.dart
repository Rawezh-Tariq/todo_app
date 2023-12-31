import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/tools/todo.dart';
import 'package:uuid/uuid.dart';

final todosProvider = AsyncNotifierProvider<MyTodos, List<Todo>>(MyTodos.new);

final todoProviderFamily = StateProviderFamily(
  (ref, String id) {
    final todo = ref
        .watch(todosProvider)
        .value!
        .firstWhere((element) => element.id == id);
    return todo;
  },
);

class MyTodos extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    final supabaseTodos =
        await Supabase.instance.client.from('todo_table').select();
    final todos = supabaseTodos.map((e) => Todo.fromMap(e)).toList();

    return todos;
  }

  Future<void> addTodo(String title, String body) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newTodo = Todo(
          title: title, body: body, id: const Uuid().v4(), togglecheck: false);

      await Supabase.instance.client.from('todo_table').insert(newTodo.toMap());

      final value = [...?state.value, newTodo];

      return value;
    });
  }

  Future<void> deleteTodo(String id) async {
    //state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.from('todo_table').delete().eq('id', id);
      final value = [...?state.value];
      value.removeWhere((element) => element.id == id);

      return value;
    });
  }

  Future<void> updateTodo(String id, String title, String body) async {
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client
          .from('todo_table')
          .update({'title': title, 'body': body}).match({'id': id});
      final value = [...?state.value];
      final oldTodo = value.firstWhere((element) => element.id == id);
      final index = value.indexOf(oldTodo);
      value[index] = oldTodo.copyWith(
        title: title,
        body: body,
      );

      return value;
    });
  }

  Future<void> togglecheck(String id) async {
    final todo = state.value?.firstWhere((element) => element.id == id);
    final togglecheck = !(todo?.togglecheck ?? false);
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client
          .from('todo_table')
          .update({'togglecheck': togglecheck}).eq('id', id);

      final value = [...?state.value];
      final oldTodo = value.firstWhere((element) => element.id == id);
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
          .from('todo_table')
          .delete()
          .eq('togglecheck', true);
      final value = [...?state.value];
      value.removeWhere((element) => element.togglecheck == true);
      return value;
    });
  }
}
