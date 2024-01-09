import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/tools/riverpod_observer.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cnbfpdqpmvhowmtthdnw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNuYmZwZHFwbXZob3dtdHRoZG53Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM4NzQ4MDMsImV4cCI6MjAxOTQ1MDgwM30.kcJcj0aZIJnTGN4xMf25u6wMZNqaenH-7ScqvFgSd8g',
  );

  runApp(
    const ProviderScope(
      observers: [
        RiverpodObserver(),
      ],
      child: TodoApp(),
    ),
  );
}
