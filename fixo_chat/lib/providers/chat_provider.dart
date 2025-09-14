import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  Future<void> loadMessages(
      String token, int receiverId, String receiverType) async {
    _messages = await ApiService.fetchMessages(token, receiverId, receiverType);
    notifyListeners();
  }

  Future<void> sendMessage(
    String token,
    int senderId,
    int receiverId,
    String senderType,
    String receiverType,
    String message,
  ) async {
    final newMessage = await ApiService.sendMessage(
      token,
      senderId,
      receiverId,
      senderType,
      receiverType,
      message,
    );
    _messages.add(newMessage);
    notifyListeners();
  }
}
