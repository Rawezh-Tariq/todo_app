import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _auth = Supabase.instance.client.auth;

final isSignUp = StateProvider((ref) => true);

final authProvider =
    AsyncNotifierProvider<AuthProvider, void>(AuthProvider.new);

class AuthProvider extends AsyncNotifier<void> {
  @override
  build() {}

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _auth
          .signUp(
            email: email,
            password: password,
          )
          .whenComplete(() async => await _auth.signInWithPassword(
                email: email,
                password: password,
              ));
    });
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _auth.signInWithPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  get userId => _auth.currentUser?.id;
}
