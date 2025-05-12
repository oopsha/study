import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const CustomerApp());
}

class CustomerApp extends StatefulWidget {
  const CustomerApp({super.key});

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  WebSocket? _socket;
  String _status = '서버에 연결되지 않음';
  String _receivedMessage = '';

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() async {
    try {
      final socket = await WebSocket.connect('ws://localhost:8080');
      setState(() {
        _socket = socket;
        _status = 'POS 서버에 연결됨';
      });

      socket.listen((data) {
        setState(() {
          _receivedMessage = data.toString();
        });
      });

      socket.add('고객: 메뉴 선택 완료');
    } catch (e) {
      setState(() {
        _status = '연결 실패: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '고객 앱',
      home: Scaffold(
        appBar: AppBar(title: const Text('고객 앱 - WebSocket 클라이언트')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('상태: $_status'),
              const SizedBox(height: 16),
              Text('수신 메시지: $_receivedMessage'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _socket?.add('고객: 결제 요청');
                },
                child: const Text('메시지 전송'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
