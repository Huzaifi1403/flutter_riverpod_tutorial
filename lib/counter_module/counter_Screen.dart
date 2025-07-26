import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/counter_module/counterProvider.dart';
import 'package:flutter_riverpod_tutorial/counter_module/display_homepage_banner.dart';
import 'package:flutter_riverpod_tutorial/counter_module/weekly_calendar_view.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss the keyboard
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1F1E28),
              Color(0xff005CC0),
              Color(0xffffffff),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                displayUserHeading(),
                const DisplayHomepageBanner(),
              ],
            ),
            // floatingActionButton: Padding(
            //   padding: const EdgeInsets.only(bottom: 50),
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       // Implement your increment logic here
            //       ref.read(counterProvider.notifier).increment();
            //     },
            //     tooltip: 'Increment',
            //     child: const Icon(Icons.add),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }

  Padding displayUserHeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Managed by',
                        style: TextStyle(
                            color: Colors.white.withAlpha(200), fontSize: 8)),
                    Text('PropTech Sdn Bhd',
                        style: TextStyle(
                            color: Colors.white.withAlpha(200), fontSize: 8))
                  ],
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.qr_code,
                        size: 14,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        size: 14,
                        Icons.notifications,
                        color: Colors.white,
                      )),
                )
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Row(
                children: [
                  const Text(
                    'T2-18-01, Tower 2',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  GestureDetector(
                    child:
                        Icon(Icons.person, color: Colors.white.withAlpha(200)),
                  )
                ],
              ),
              dense: true,
              subtitle: const Text('NovaPoint',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              trailing: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Sunny',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 10),
                Icon(Icons.wb_sunny, color: Colors.white.withAlpha(200)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
