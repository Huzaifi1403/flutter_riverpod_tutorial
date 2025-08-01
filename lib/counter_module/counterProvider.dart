import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterProvider extends StateNotifier<int> {
  CounterProvider() : super(0);

  int get counter => state;

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}

final counterProvider = StateNotifierProvider<CounterProvider, int>((ref) {
  return CounterProvider();
});
