import 'package:go_router/go_router.dart';

import 'package:todoapp/pages/addingtodo_page.dart';
import 'package:todoapp/pages/editing_page.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/pages/todo_page.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/AddTodo',
      builder: (context, state) => const AddingTodo(),
    ),
    GoRoute(
      path: '/EditTodo/:title/:body/:id/:index',
      builder: (context, state) => EditingPage(
        title: state.pathParameters['title']!,
        body: state.pathParameters['body']!,
        id: state.pathParameters['id']!,
        index: int.parse(state.pathParameters['index']!),
      ),
    ),
    GoRoute(
      path: '/TodoPage/:id/:index',
      builder: (context, state) => TodoPage(
        id: state.pathParameters['id']!,
        index: int.parse(state.pathParameters['index']!),
      ),
    ),
  ],
);
