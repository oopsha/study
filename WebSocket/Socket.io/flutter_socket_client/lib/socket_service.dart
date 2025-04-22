import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;

  void connect({required String companyCode, required String storeCode}) {
    _socket = IO.io(
      'http://58.72.109.3:8200',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'companyCode': companyCode, 'storeCode': storeCode})
          .disableAutoConnect()
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print('✅ Connected');
    });

    _socket.on('kds-update', (data) {
      print('📥 Message: $data');
    });

    _socket.onDisconnect((_) {
      print('❌ Disconnected');
    });
  }

  void sendMessage(Map<String, dynamic> data) {
    _socket.emit('pos-message', data);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
