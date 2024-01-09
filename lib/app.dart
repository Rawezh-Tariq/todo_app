import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/page_routes/routes.dart';
import 'package:todoapp/tools/theme.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
