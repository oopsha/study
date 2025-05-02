import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class SocketService {
  late socket_io.Socket socket;

  void connect({required void Function(String msg) onMessageReceived}) {
    socket = socket_io.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      debugPrint('✅ Connected to Socket.IO Server');
    });

    socket.on('chat message', (data) {
      debugPrint('📩 Message from server: $data');
      onMessageReceived(data.toString());
    });

    socket.onDisconnect((_) {
      debugPrint('❌ Disconnected from Socket.IO server');
    });

    socket.onError((data) {
      debugPrint('⚠️ Error: $data');
    });
  }

  void sendMessage(String msg) {
    socket.emit('chat message', msg);
  }

  void disconnect() {
    debugPrint(
        'Disconnect Socket.io for chat message... but 80 lines trimming fdjkaldfkfndkal');
    socket.disconnect();
  }
}
