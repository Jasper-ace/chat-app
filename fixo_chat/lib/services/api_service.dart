import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  // Login
  static Future<Map<String, dynamic>> login(
      String email, String password, String type) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$type/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  // Fetch messages
  static Future<List<dynamic>> fetchMessages(String token, int receiverId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/messages/$receiverId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  // Send message
  static Future<Map<String, dynamic>> sendMessage(
      String token, int receiverId, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages/send'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'receiver_id': receiverId,
        'message': message,
      }),
    );
    return jsonDecode(response.body);
  }
}
