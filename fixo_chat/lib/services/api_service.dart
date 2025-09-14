import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/message.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api"; // use 10.0.2.2 for emulator

  // Login
  static Future<User?> login(String email, String password, String userType) async {
    final url = Uri.parse("$baseUrl/$userType/login");
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }
    return null;
  }

  // Fetch all users (tradies or homeowners)
  static Future<List<User>> fetchUsers(String userType) async {
    final url = Uri.parse("$baseUrl/$userType");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    }
    return [];
  }

  // Fetch messages
  static Future<List<Message>> fetchMessages(int receiverId, String receiverType) async {
    final url = Uri.parse("$baseUrl/messages/$receiverId/$receiverType");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    }
    return [];
  }

  // Send message
  static Future<bool> sendMessage(int senderId, String senderType, int receiverId, String message) async {
    final url = Uri.parse("$baseUrl/messages/send");
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "sender_id": senderId,
          "sender_type": senderType,
          "receiver_id": receiverId,
          "message": message
        }));
    return response.statusCode == 200;
  }
}
