import 'package:flutter/material.dart';

class Hilmanbusuk extends StatelessWidget {
  final String? title;
  const Hilmanbusuk({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return showText();
  }

  Text showText() => Text(
        'hilman mmg',
        style: TextStyle(),
      );
}
