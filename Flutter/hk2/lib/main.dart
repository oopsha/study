import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eldorado Resort - Housekeeping Management',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(236, 238, 246, 1.0),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          const Spacer(),
          Container(
            color: Colors.purple.withValues(alpha: 0.12),
            width: 1080,
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildRoomStatusHeader(ref),
              ]
            ),
          ),
          const Spacer(),
        ]
      )
    );
  }

  Widget _buildRoomStatusHeader(WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: const Offset(1.0, 1.0),
                blurRadius: 3.0,
              ),
            ],
            color: Colors.white,
          ),
          height: 72,
          width: 133,
        )
      ]
    );
  }
}
