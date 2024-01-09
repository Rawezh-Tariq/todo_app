import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final auth = Supabase.instance.client.auth;

final userProvider = Provider<User?>((ref) {
  final subscription = auth.onAuthStateChange.listen((event) {
    if (ref.state != event.session?.user) {
      ref.invalidateSelf();
    }
  });

  ref.onDispose(() => subscription.cancel());

  return auth.currentUser;
});

final authProvider = AsyncNotifierProvider<AuthProvider, void>(() {
  return AuthProvider();
});

class AuthProvider extends AsyncNotifier<void> {
  @override
  build() {}

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await auth.signUp(
        email: email,
        password: password,
      );
      return;
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
}
