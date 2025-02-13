import 'package:app/Application/State/authentication_state.dart';
import 'package:app/Application/UseCase/authentication_use_case.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationProvider);
    final authNotifier = ref.read(authenticationProvider.notifier);

    ref.listen(authenticationProvider, (previous, next) {
      if (next == AuthenticationState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
        // Navigate to home page
      } else if (next == AuthenticationState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid credentials")),
        );
      }
    });

    String username = "";
    String password = "";

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Username"),
              onChanged: (value) => username = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: authState == AuthenticationState.loading
                  ? null
                  : () => authNotifier.login(context, username, password),
              child: authState == AuthenticationState.loading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
