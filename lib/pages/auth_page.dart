import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final auth = ref.watch(authProvider.notifier);
    final isItSignUp = ref.watch(isSignUp);
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
              isItSignUp ? 'Sign Up' : 'Sign In',
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
            Column(
              children: [
                ElevatedButton(
                  onPressed: _emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty
                      ? () {
                          isItSignUp
                              ? auth.signUp(_emailController.text,
                                  _passwordController.text)
                              : auth.signIn(_emailController.text,
                                  _passwordController.text);
                        }
                      : null,
                  child: Text(isItSignUp ? 'Sign Up' : 'Sign In'),
                ),
                TextButton(
                  child: Text(isItSignUp ? 'Sign In' : 'Sign Up'),
                  onPressed: () {
                    ref.read(isSignUp.notifier).state = !isItSignUp;
                    _emailController.clear();
                    _passwordController.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
