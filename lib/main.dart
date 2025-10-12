import 'package:flutter/material.dart';
import 'authentication_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Tela de Login'),
      ),
    );
  }
}
