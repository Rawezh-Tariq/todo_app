import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/pages/add_todo_page.dart';
import 'package:todoapp/pages/edit_page.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/pages/sign_up_page.dart';
import 'package:todoapp/pages/todo_page.dart';
import 'package:todoapp/providers/auth_provider.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final goRouterProvider = Provider(
  (ref) => GoRouter(
    refreshListenable: GoRouterRefreshStream(
      Supabase.instance.client.auth.onAuthStateChange,
    ),
    redirect: (context, state) {
      final path = state.fullPath;
      final isLoggedIn = ref.read(userProvider) != null;

      if (isLoggedIn) {
        if (path == '/signUp') {
          return '/';
        }
      } else {
        if (path != '/signUp') {
          return '/';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: '/addTodo',
        builder: (context, state) => const AddingTodo(),
      ),
      GoRoute(
        path: '/editTodo/:title/:body/:id',
        builder: (context, state) => EditingPage(
          title: state.pathParameters['title']!,
          body: state.pathParameters['body']!,
          id: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/todo/:id',
        builder: (context, state) => TodoPage(
          id: state.pathParameters['id']!,
        ),
      ),
    ],
  ),
);
