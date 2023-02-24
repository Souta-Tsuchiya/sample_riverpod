import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_riverpod/providers.dart';

class Home extends ConsumerWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(0.5),
            1: FlexColumnWidth(0.5),
          },
          children: [
            // Provider
            TableRow(children: [
              Center(
                  child: const Text(
                "Provider",
                style: TextStyle(fontSize: 20.0),
              )),
              Consumer(builder: (BuildContext context, WidgetRef ref, child) {
                final doubleCount = ref.watch(doubleCountProvider);
                return Center(
                    child: Text(
                  doubleCount.toString(),
                  style: TextStyle(fontSize: 25.0),
                ));
              })
            ]),

            //StateProvider
            TableRow(children: [
              Center(child: const Text("StateProvider", style: TextStyle(fontSize: 20.0))),
              Consumer(builder: (BuildContext context, WidgetRef ref, child) {
                final countState = ref.watch(countStateProvider);
                return Center(child: Text(countState.toString(), style: TextStyle(fontSize: 25.0)));
              })
            ]),

            //StateNotifierProvider
            TableRow(children: [
              Center(child: const Text("StateNotifierProvider", style: TextStyle(fontSize: 20.0))),
              Consumer(builder: (BuildContext context, WidgetRef ref, child) {
                final countStateNotifier = ref.watch(countStateNotifierProvider);
                return Center(
                    child: Text(countStateNotifier.toString(), style: TextStyle(fontSize: 25.0)));
              })
            ]),

            //FutureProvider
            TableRow(children: [
              Center(child: const Text("FutureProvider", style: TextStyle(fontSize: 20.0))),
              Consumer(builder: (BuildContext context, WidgetRef ref, child) {
                final countFuture = ref.watch(countFutureProvider);
                return Center(
                  child: Text(
                    countFuture.when(
                      data: (String data) => data,
                      error: (_, __) => "error",
                      loading: () => "loading",
                    ),
                    style: TextStyle(fontSize: 25.0),
                  ),
                );
              })
            ]),

            //StreamProvider
            TableRow(children: [
              Center(child: const Text("StreamProvider", style: TextStyle(fontSize: 20.0))),
              Consumer(builder: (BuildContext context, WidgetRef ref, child) {
                final countStream = ref.watch(countStreamProvider);
                return Center(
                  child: Text(
                    countStream.when(
                      data: (int data) => data.toString(),
                      error: (_, __) => "error",
                      loading: () => "loading",
                    ),
                    style: TextStyle(fontSize: 25.0),
                  ),
                );
              })
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countStateNotifierProvider.notifier).increment();
          ref.read(countStateProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
