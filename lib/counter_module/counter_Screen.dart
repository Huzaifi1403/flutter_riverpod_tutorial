import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/counter_module/counterProvider.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss the keyboard
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Riverpod Counter'),
        ),
        body: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 64),
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //     labelText: 'Email',
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //         color: Colors.blueAccent,
                        //         width: 2.0,
                        //       ),
                        //       borderRadius: BorderRadius.circular(8.0),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8.0),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your email';
                        //     }
                        //     // Simple email validation
                        //     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        //         .hasMatch(value)) {
                        //       return 'Please enter a valid email';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // const SizedBox(height: 16),
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //     labelText: 'Password',
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8.0),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your password';
                        //     }
                        //     if (value.length < 6) {
                        //       return 'Password must be at least 6 characters';
                        //     }
                        //     return null;
                        //   },
                        //   obscureText: true,
                        // ),
                        // const SizedBox(height: 16),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (formKey.currentState?.validate() ?? false) {
                        //       // Handle form submission
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         const SnackBar(
                        //           content: Text('Form submitted successfully!'),
                        //         ),
                        //       );
                        //     }
                        //   },
                        //   child: const Text('Submit'),
                        // ),
                        const SizedBox(height: 8),
                        const Text(
                          'You have pushed the button this many times:',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$counter',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Implement your increment logic here
            ref.read(counterProvider.notifier).increment();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
