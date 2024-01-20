import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/pages/add_todo_page.dart';
import 'package:todoapp/pages/edit_page.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/pages/auth_page.dart';
import 'package:todoapp/pages/todo_page.dart';

class StreamListenable extends ChangeNotifier {
  StreamListenable(Stream stream) {
    subscription = stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription subscription;

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

final goRouterProvider = Provider(
  (ref) => GoRouter(
    refreshListenable:
        StreamListenable(Supabase.instance.client.auth.onAuthStateChange),
    redirect: (context, state) {
      final user = Supabase.instance.client.auth.currentUser;
      if (state.matchedLocation == '/auth' && user != null) {
        return '/';
      }

      if (state.matchedLocation != '/auth' && user == null) {
        return '/auth';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: '/addTodo',
        builder: (context, state) => const AddingTodo(),
      ),
      GoRoute(
        path: '/editTodo/:title/:body/:todo_id',
        builder: (context, state) => EditingPage(
          title: state.pathParameters['title']!,
          body: state.pathParameters['body']!,
          todoId: state.pathParameters['todo_id']!,
        ),
      ),
      GoRoute(
        path: '/todo/:todo_id',
        builder: (context, state) => TodoPage(
          todoId: state.pathParameters['todo_id']!,
        ),
      ),
    ],
  ),
);
