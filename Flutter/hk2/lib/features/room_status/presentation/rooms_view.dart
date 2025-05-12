import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk2/shared/extensions/string_extensions.dart';

class RoomsView extends ConsumerWidget {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Container(color: Colors.red.shade100, height: 300);

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
            ),
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            child: Row(
              children: [
                const Text('A1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Row(
                  spacing: 4.0,
                  children: [
                    const SizedBox(width: 8.0),
                    ...List.generate(9, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: '#3a4359'.toColor(),
                        ),
                        height: 28,
                        width: 38,
                        child: const Center(
                          child: Text('301', style: TextStyle(color: Colors.white)),
                        )
                      );
                    }),
                    // const SizedBox(width: 4.0),
                  ]
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
            ),
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            child: Row(
              children: [
                const Text('E2', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Row(
                  spacing: 4.0,
                  children: [
                    const SizedBox(width: 8.0),
                    ...List.generate(9, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: '#ffc107'.toColor(),
                        ),
                        height: 28,
                        width: 38,
                        child: const Center(
                          child: Text('301', style: TextStyle(color: Colors.white)),
                        )
                      );
                    }),
                    // const SizedBox(width: 4.0),
                  ]
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}