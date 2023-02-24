import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//Provider
final doubleCountProvider = Provider<int>((ref) {
  final count = ref.watch(countStateNotifierProvider);
  return count * 2;
});


//StateProvider
final countStateProvider = StateProvider<int>((ref) => 0);


//StateNotifierProvider
class CountStateNotifier extends StateNotifier<int> {
  CountStateNotifier(): super(0);

  void increment() => state++;
}

final countStateNotifierProvider = StateNotifierProvider<CountStateNotifier, int>((ref) {
  return CountStateNotifier();
});


//FutureProvider
final countFutureProvider = FutureProvider<String>((ref) async {
  await Future.delayed(const Duration(seconds: 6));
  return "6秒経過！";
});


//StreamProvider
Stream<int> randomValueStream() async* {
  final random = Random();
  while(true) {
    await Future.delayed(const Duration(seconds: 1));
    yield random.nextInt(100);
  }
}

final countStreamProvider = StreamProvider<int>((ref) => randomValueStream());