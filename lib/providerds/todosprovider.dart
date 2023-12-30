import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/tools/todo.dart';
import 'package:uuid/uuid.dart';

final todosProvider = AsyncNotifierProvider<MyTodos, List<Todo>>(MyTodos.new);
//const todosKey = 'todos';

class MyTodos extends AsyncNotifier<List<Todo>> {
  //late final SharedPreferences pref;
  @override
  Future<List<Todo>> build() async {
    final supabaseTodos =
        await Supabase.instance.client.from('todo_table').select();
    final todos = supabaseTodos.map((e) => Todo.fromMap(e)).toList();

    return todos;

    // pref = await SharedPreferences.getInstance();
    // final todosString = pref.getString(todosKey);
    // if (todosString == null) {
    //   return [];
    // }
    // final todos = jsonDecode(todosString) as List<dynamic>;
    // return todos.map((e) => Todo.fromMap(e)).toList();
  }

  //Future<bool> _updateSharedPref(List<Todo> value) => pref.setString(
  //  todosKey, jsonEncode(value.map((e) => e.toMap()).toList()));

  Future<void> addTodo(String title, String body) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newTodo = Todo(
          title: title, body: body, id: const Uuid().v4(), togglecheck: false);

      await Supabase.instance.client.from('todo_table').insert(newTodo.toMap());

      // final newTodo = Todo(title: title, body: body, id: const Uuid().v4());
      final value = [...?state.value, newTodo];
      // await _updateSharedPref(value);
      return value;
    });
  }

  Future<void> deleteTodo(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.from('todo_table').delete().eq('id', id);
      final value = [...?state.value];
      value.removeWhere((element) => element.id == id);
      // await _updateSharedPref(value);
      return value;
    });
  }

  Future<void> updateTodo(String id, String title, String body) async {
    //state = const AsyncLoading();
    // state = await AsyncValue.guard(() async {
    return await Supabase.instance.client
        .from('todo_table')
        .update({'title': title, 'body': body});
    // final value = [...?state.value];
    // final oldTodo = value.firstWhere((element) => element.id == id);
    // final index = value.indexOf(oldTodo);
    // value[index] = oldTodo.copyWith(
    //   title: title,
    //   body: body,
    // );
    // await _updateSharedPref(value);
    // return value;
    // });
  }

  Future<void> togglecheck(bool togglecheck) async {
    // state = const AsyncLoading();
    // state = await AsyncValue.guard(() async {
    return await Supabase.instance.client
        .from('todo_table')
        .update({'isItChechked': !togglecheck});
    // final value = [...?state.value];
    // final oldTodo = value.firstWhere((element) => element.id == id);
    // final index = value.indexOf(oldTodo);
    // value[index] = oldTodo.copyWith(
    //   isItChechked: !oldTodo.isItChechked,
    // );
    // await _updateSharedPref(value);
    // return value;
    // });
  }

  Future<void> reOrderTodo(int oldIndex, int newIndex) async {
    // state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final value = [...?state.value];
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      value.insert(newIndex, value.removeAt(oldIndex));

      return value;
    });
  }

  // Future<void> deleteAllTodos() async {
  //   state = await AsyncValue.guard(() async {
  //     final value = [...?state.value];
  //     value.clear();
  //     // await Supabase.instance.client.from('todo_table').delete();
  //     // await pref.remove('todos');
  //     // return [];
  //     return value;
  //   });
  // }
}
