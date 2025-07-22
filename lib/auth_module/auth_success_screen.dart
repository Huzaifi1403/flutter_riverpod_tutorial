import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/kBottomBar.dart';

class AuthSuccessScreen extends StatelessWidget {
  const AuthSuccessScreen(
      {super.key, required this.email, required this.token});

  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: $email'),
            const SizedBox(height: 20),
            Text('Token: $token'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle logout or navigation
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const KBottomBar(
                    currentIndex: 3,
                  ),
                ));
                debugPrint('Logout button pressed');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
