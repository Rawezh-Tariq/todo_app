import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final auth = Supabase.instance.client.auth;

final isSignUp = StateProvider((ref) => true);

// final authStream = Provider<StreamSubscription<AuthState>>(
//   (ref) => auth.onAuthStateChange.listen((authState) {
//     if (authState.event == AuthChangeEvent.signedIn) {
//       ref.invalidate(todosProvider);
//     }
//   }),
// );

final authProvider =
    AsyncNotifierProvider<AuthProvider, void>(AuthProvider.new);

class AuthProvider extends AsyncNotifier<void> {
  @override
  build() {}

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await auth
          .signUp(
            email: email,
            password: password,
          )
          .whenComplete(() async => await auth.signInWithPassword(
                email: email,
                password: password,
              ));
    });
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await auth.signInWithPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  get userId => auth.currentUser?.id;
}
