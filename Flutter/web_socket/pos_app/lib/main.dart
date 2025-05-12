import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const POSApp());
  startWebSocketServer();
}

class POSApp extends StatelessWidget {
  const POSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS 앱 (서버)',
      home: Scaffold(
        appBar: AppBar(title: const Text('POS 앱 - WebSocket 서버')),
        body: const Center(
          child: Text('고객 앱이 접속하면 메시지를 주고받습니다.'),
        ),
      ),
    );
  }
}

void startWebSocketServer() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('POS WebSocket 서버 실행 중: ws://${server.address.address}:${server.port}');

  await for (HttpRequest request in server) {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      final socket = await WebSocketTransformer.upgrade(request);
      print('고객 앱 연결됨');

      socket.listen((data) {
        print('고객 앱 메시지: $data');
        socket.add('POS 응답: [$data] 잘 받았습니다.');
      });
    } else {
      request.response
        ..statusCode = HttpStatus.forbidden
        ..close();
    }
  }
}
