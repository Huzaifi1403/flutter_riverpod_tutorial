import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/dynamic_bottom_bar_module.dart/example_bottom_bar.dart';
import 'package:flutter_riverpod_tutorial/kBottomBar.dart';
import 'package:flutter_riverpod_tutorial/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getTheme(),
      home: const ExampleBottomBar(),
    );
  }
}
