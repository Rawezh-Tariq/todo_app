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
      path: '/EditTodo/:title/:body/:id',
      builder: (context, state) => EditingPage(
        title: state.pathParameters['title']!,
        body: state.pathParameters['body']!,
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/TodoPage/:id',
      builder: (context, state) => TodoPage(
        id: state.pathParameters['id']!,
      ),
    ),
  ],
);
