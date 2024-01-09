import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/providers/auth_provider.dart';
import 'package:todoapp/tools/theme.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProviderr = ref.watch(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: myTheme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            TextField(
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Write your email here',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Write your password here',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty
                  ? () {
                      authProviderr.signUp(
                        _emailController.text,
                        _passwordController.text,
                      );
                      context.go('/');
                    }
                  : null,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
