import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/api_service.dart';
import '../services/socket_service.dart';

class ChatProvider extends ChangeNotifier {
  final SocketService socketService = SocketService();
  List<Message> messages = [];

  void initSocket(String userId) {
    socketService.connect(userId);
    socketService.socket.on('new_message', (data) {
      messages.add(Message.fromJson(data));
      notifyListeners();
    });
  }

  Future<void> fetchMessages(String token, int receiverId) async {
    final msgs = await ApiService.fetchMessages(token, receiverId);
    messages = msgs.map((e) => Message.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> sendMessage(
    String token,
    int receiverId,
    String text,
    int senderId,
  ) async {
    // Call API
    await ApiService.sendMessage(token, receiverId, text);

    // Notify socket
    socketService.sendMessage({
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': text,
    });

    // Optimistic update (add to UI immediately)
    messages.add(Message(
      id: 0,
      senderId: senderId,
      receiverId: receiverId,
      message: text,
      isRead: false,
      createdAt: DateTime.now(),
    ));
    notifyListeners();
  }
}
