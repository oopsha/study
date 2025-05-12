import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io_client;

class SocketService {
  late socket_io_client.Socket _socket;

  void connect({required String companyCode, required String storeCode}) {
    _socket = socket_io_client.io(
      // 'http://localhost:8200',
      'http://58.72.109.3:8200',
      socket_io_client.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'companyCode': companyCode, 'storeCode': storeCode})
          .disableAutoConnect()
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint('✅ Connected');
    });

    _socket.on('order-new', (data) {
      debugPrint('📥 order-new, Message: $data');
    });

    _socket.on('order-complete', (data) {
      debugPrint('📥 order-complete, Message: $data');
    });

    _socket.onDisconnect((_) {
      debugPrint('❌ Disconnected');
    });
  }

  void sendMessage(Map<String, dynamic> data) {
    final payload = {
      'eventName': 'order-new',
      'data': data,
    };
    _socket.emit('event', payload);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
