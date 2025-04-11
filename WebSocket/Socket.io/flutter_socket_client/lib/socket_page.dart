import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';

class SocketPage extends ConsumerStatefulWidget {
  const SocketPage({super.key});

  @override
  ConsumerState<SocketPage> createState() => _SocketPageState();
}

class _SocketPageState extends ConsumerState<SocketPage> {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(socketServiceProvider).connect(companyCode: '10001', storeCode: '00001');
  }

  @override
  void dispose() {
    ref.read(socketServiceProvider).disconnect();
    super.dispose();
  }

  void _sendMessage() {
    final msg = messageController.text.trim();
    if (msg.isNotEmpty) {
      ref.read(socketServiceProvider).sendMessage({'message': msg});
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Socket.IO + Riverpod')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send POS Message'),
            ),
          ],
        ),
      ),
    );
  }
}
