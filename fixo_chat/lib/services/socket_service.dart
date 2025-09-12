import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(String userId) {
    socket = IO.io('http://127.0.0.1:8080', <String, dynamic>{
      'transports': ['websocket'],
      'query': {'user_id': userId},
    });

    socket.onConnect((_) {
      print('Connected to socket server');
    });

    socket.on('new_message', (data) {
      print('New message: $data');
    });
  }

  void sendMessage(Map<String, dynamic> data) {
    socket.emit('send_message', data);
  }

  void disconnect() {
    socket.disconnect();
  }
}
