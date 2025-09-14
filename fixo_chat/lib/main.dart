import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const FixoChatApp());
}

class FixoChatApp extends StatelessWidget {
  const FixoChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fixo Chat-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
