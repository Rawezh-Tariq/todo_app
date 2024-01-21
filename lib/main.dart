import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoapp/tools/riverpod_observer.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hiskezvyfoxymeergrpj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhpc2tlenZ5Zm94eW1lZXJncnBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU0MDk5MzcsImV4cCI6MjAyMDk4NTkzN30.u--JEy4GMPk4lnrQpdoJr65Hs8W9t1mpaIomxBwmQhw',
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
