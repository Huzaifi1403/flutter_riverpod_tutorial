import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/auth_module/auth_provider.dart';
import 'package:flutter_riverpod_tutorial/auth_module/auth_state.dart';
import 'package:flutter_riverpod_tutorial/auth_module/auth_success_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  AuthScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      // Check if registration or login was successful
      if (next.isLoggedIn && next.authResult.hasValue && context.mounted) {
        // Navigate to a new page
        if (next.authResult.value == 'wrong credentials') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong credentials, please try again'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => AuthSuccessScreen(
                    email: next.email ?? "",
                    token: next.authResult.value ?? "",
                  )),
        );
      } else if (next.authResult.hasError && context.mounted) {
        // Show error message
        debugPrint('Error login (Screen): ${next.authResult.error}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to authenticate'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Authentication'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text('Welcome to the Auth Screen!'),
                  const Divider(),
                  const Text('use this email and password to login'),
                  const Text('email: eve.holt@reqres.in'),
                  const Text('password: Abc123456'),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  ElevatedButton(
                    onPressed: authState.authResult.isLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              final email = emailController.text;
                              final password = passwordController.text;

                              ref
                                  .read(authNotifierProvider.notifier)
                                  .login(email: email, password: password);

                              // emailController.clear();
                              // passwordController.clear();
                            }
                          },
                    child: Text(
                      'Authenticate',
                      style: TextStyle(
                          color: authState.authResult.isLoading
                              ? Colors.grey
                              : Colors.purpleAccent),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: authState.authResult.isLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              final email = emailController.text;
                              final password = passwordController.text;

                              ref
                                  .read(authNotifierProvider.notifier)
                                  .register(email: email, password: password);
                            }
                          },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: authState.authResult.isLoading
                              ? Colors.grey
                              : Colors.purpleAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
